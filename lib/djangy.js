//include some must have files
child_proc  		= require('child_process');


//set some global variables
var template_path = "";


var config = function(config_json){
		template_path = config_json["template_path"];

	}
	
var render = function(relative_path,paramsm,callback_function) {

	params 				= {};
	params["settings"]	= {};
	params["context"]	= params;
	
	params["settings"]["path"]				= template_path;
	params["settings"]["render"]			= relative_path;

	json_string = JSON.stringify(params);
	json_buffer = new Buffer(json_string);

	python_child = child_proc.spawn("python" , ["python_bind.py"]);
	
	python_child.stdin.write(json_buffer);
	python_child.stdin.end();
	
	python_child.stderr.on("data", function(data){
		callback_function( data.toString());
		}
	);

	python_child.stdout.on("data", function(data){
		callback_function(data.toString());
		}
	);

}

exports.config 	= config
exports.render	= render

