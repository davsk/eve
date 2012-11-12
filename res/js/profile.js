var submitKeys = function() {

};

var apiKeyForm;

function createApiKeyForm() {
	var form = $($("#apikeys form div:first").children().get(0)).clone();
	$(form).find("input").each(function() {
		$(this).val("");
	});
	return form;
}

function addApiKeyForm() {

}

$(function() {

	apiKeyForm = createApiKeyForm();

	$(".remove-key").live("click", function() {
		$(this).parent().parent().remove();
	});

	$(".add-key").on("click", function() {
		$("#apikeys form div:first").append(apiKeyForm.clone());
	});

});
