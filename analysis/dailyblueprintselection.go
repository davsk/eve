/*  DailyBlueprintSelection.go

for DASA on Nov 13, 2012 by David Skinner

Daily Process to Calculate Profitabily of Blueprints
Refresh on request when threshhold numbers changed

Static Files: invBuildMaterial invBlueprintTypes
Daily Files: eve_inv_types
Input Files: dasaMissions dasaSkills dasaBlueprints
Output Files: dasaProfitableT1 dasaBuildableT1
*/
package analysis

import (
	"database/sql"
	"fmt"
	_ "github.com/bmizerany/pq"
	"log"
	"math"
	"os"
	//"time"
)

type ISK int64

func (isk ISK) Set(f float64) {
	isk = ISK(f * 100)
}

func (isk ISK) Val() float64 {
	return float64(isk)/100
}

func (isk ISK) String() string {
	return fmt.Sprintf("%d.%02d", int64(isk)/100, int64(isk)%100)
}

func DailyBlueprintSelection() (err error) {
	const (
		printIt bool = true
	)

	var (
		// print to file test.prn
		fileOut *os.File

		// Threshold Values Found in MagicNumber Table
		//minDemand       float64 = 5
		minProfitHour   float64 = 200
		minProfitMargin float64 = .20
		minDemand 		int64 = 4
		factoryStart    float64     = 1000.00
		factoryHour     float64     = 333.00
		factoryDays     float64 = 14.0
		//  User Data found in header
		//  userId       int = 1002348
		userName string = "David Skinner"
		//  User Data found in skill tree
		userIndustry int = 5
		// userPE       int = 5
	)

	if printIt {
		if fileOut, err = os.Create("test.prn"); err != nil {
			return fmt.Errorf("Can't create test.prn: %s", err)
		}
		defer fileOut.Close()
	}

	// login
	db, err := sql.Open("postgres", "user=goeve password=goeve dbname=eve sslmode=disable")
	if err != nil {
		log.Fatal("sql.Open failed:", err)
	}
	defer db.Close()

	// title, subtitle, columns
	fmt.Println("Daily Blueprint Selection")
	fmt.Println("Prepared for " + userName)

	fmt.Println(
		"canBuild",
		"itemName",
		"Cost Low", 
		"Cost High",
		"Price Low", 
		"Price High", 
		"zScore", 
		"Demand", 
		"Profit Low", 
		"Margin Low", 
		"Profit High", 
		"Margin High")

	if printIt {
		_, err = fileOut.WriteString("\"canBuild\",\"itemName\",\"Cost Low\",\"Cost High\",\"Price Low\",\"Price High\",\"zScore\",\"Demand\",\"Profit Low\",\"Margin Low\",\"Profit High\",\"Margin High\"\n"); if err != nil {
			return err
		}
	}
	
	// for each T1 Blueprint
	blueprints, err := db.Query("SELECT * FROM public.productionProfit WHERE techLevel = 1;")
	if err != nil {
		return err
	}
	log.Println("Processing Blueprints")

	for blueprints.Next() {
		var (
			// ProductionProfit
			blueprintTypeId 		int
			parentBlueprintTypeId 	sql.NullInt64
			productTypeId			int
			productionTime 			int
			techLevel				int
			productivityModifier	int
			materialModifier		int
			wasteFactor				int
			maxProductionLimit		int
			name					string
			icon_name				string
			demand					sql.NullInt64
			priceSell				sql.NullFloat64
			priceBuy				sql.NullFloat64
			costSell				sql.NullFloat64
			costBuy 				sql.NullFloat64
			// Need API Skill Check
			canBuild    			bool = true
			// Results
			sumCostSell				float64
			sumCostBuy				float64
			actualTime  			float64
			factoryRuns 			int
			profitHigh  			float64
			profitLow   			float64
			marginHigh  			float64
			marginLow   			float64
			zScore      			float64
			)

		err = blueprints.Scan(
			&blueprintTypeId,
			&parentBlueprintTypeId,
			&productTypeId,
			&productionTime,
			&techLevel,
			&productivityModifier,
			&materialModifier,
			&wasteFactor,
			&maxProductionLimit,
			&name,
			&icon_name,
			&demand,
			&priceSell,
			&priceBuy,
			&costSell,
			&costBuy)

		if err != nil {
			// critical error
			return err
		}

		if priceSell.Valid && costSell.Valid && demand.Valid {
			actualTime = float64(productionTime) * (1 - (.05 * (float64(userIndustry) - 1)))
			factoryRuns = int(math.Floor(factoryDays * 24.0 * 60.0 / actualTime))
			//  Factory Cost
			sumCostSell = (factoryStart + (factoryHour * (float64(factoryRuns) * float64(actualTime)) / 60.0)) / float64(factoryRuns * productivityModifier)
			sumCostBuy = sumCostSell
			sumCostSell += costSell.Float64
			sumCostBuy += costBuy.Float64
			profitHigh = priceSell.Float64 - costBuy.Float64
			profitLow = priceBuy.Float64 - costSell.Float64
			marginHigh = float64(profitHigh / priceSell.Float64)
			marginLow = float64(profitLow / priceBuy.Float64)
			profitHigh = (profitHigh * float64(productivityModifier) * 60 / float64(actualTime))
			profitLow = (profitLow * float64(productivityModifier) * 60 / float64(actualTime))
			zScore = math.Log(profitHigh/minProfitHour) * marginHigh * math.Log(float64(demand.Int64))

			if demand.Int64 < minDemand {
				zScore = 0
			}
			if profitHigh < minProfitHour {
				zScore = 0
			}
			if marginHigh < minProfitMargin {
				zScore = 0
			}
			if profitLow > minProfitHour {
				zScore *= 4
			}
			if marginLow > minProfitMargin {
				zScore *= 8
			}
			//if zScore > 0 {
				fmt.Println(canBuild, name, sumCostBuy, sumCostSell, priceBuy.Float64 , priceSell.Float64, zScore, demand.Int64, profitLow, marginLow, profitHigh, marginHigh)
			//}
			if printIt {
				_, err = fileOut.WriteString(fmt.Sprintf(
					"%t,\"%s\",%.2f,%.2f,%.2f,%.2f,%.2f,%d,%.2f,%.2f,%.2f,%.2f\n",
					canBuild, name, sumCostBuy, sumCostSell, priceBuy.Float64 , priceSell.Float64, zScore, demand.Int64, profitLow, marginLow, profitHigh, marginHigh))
				if err != nil {
					return err
				}
			}
		
		}		
	}

	return nil
}

/*
 Blueprint Selection - Admin Only

This is a view of a table created each night, with related boolean Can Build filter with itemId * userId 

Form with filter amounts
    ProfitMargin
    Profit/Hour
    Volume
    Quantity/Production Time
    Z-Score
    Boolean Can Build
    Boolean Have Blueprint

List Items sorted descending Z-Score
    Item
    Z-Score
    ProfitMargin
    Profit/Hour
    Volume
    Quantity/Production Time
    Low Sell
    Average
    High Buy
    Slope
    CountBlueprints

Each line has a Show Info button and Set Market button for the blueprint.
*/
