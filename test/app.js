djangy = require("djangy");

console.log();

djangy.config({"template_path": __dirname + "/templates/" });

djangy.render("index.htm",{}, function(data) {
	console.log(data);
	}
	);
