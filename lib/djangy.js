//include some must have files
child_proc  		= require('child_process');


//set some global variables
var template_path 	= "";
var sanity_check 	= false;


var validate = function(){
	
	// run a python -c "import django" command to check if python and django are installed
	check_sanity = child_proc.spawn("python", ['-c', "import django"]);
	
	
	check_sanity.on('exit', function (code) {
	  if (code == 0){
	  	sanity_check = true;
	  }
	  else
	  {
	 	throw new Error('Could not call python with django, please try to execute python -c "import django" ') 
	  }
	});
	
var render = function(relative_path,render_params,callback_function) {

	if (!template_path) {
		throw new Error('Config was never called.') 
	}
	
	if (!sanity_check) {
		throw new Error('Could not call python with django, please try to execute python -c "import django" ') 
	}

	params 				= {};
	params["settings"]	= {};
	params["context"]	= render_params;
	
	params["settings"]["path"]				= template_path;
	params["settings"]["render"]			= relative_path;

	console.log(params);

	json_string = JSON.stringify(params);
	json_buffer = new Buffer(json_string);


	python_child = child_proc.spawn("python" , [ __dirname + "/python_bind.py"]);
	
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

//let the user set variables
exports.config 			= config
exports.render			= render

