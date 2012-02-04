this is a really early release to render django templates in node.

some sample code:

  djangy = require("djangy");

console.log();

djangy.config({"template_path": __dirname + "/templates/" });

djangy.render("index.htm",{}, function(data) {
  console.log(data);
	}
	);

more example code in the test folder.

made by Max Presman (max@presman.ca) and Amsul Naeem (reach@amsul.ca)