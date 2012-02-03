express 	= require "express"
exec  = require('child_process').exec
app			= express.createServer()

app.get '/', (req, resp) ->
	params 	= {}
	params["settings"]	= {}
	params["context"]	= {}
	
	params["settings"]["path"]				= __dirname + "/templates/"
	params["settings"]["render"]			= "index.html"
	
	params["context"]["sexi_stuff"]			= "moose"
	params["context"]["make_me_awesome"]	= "Wtf_yo"

	moose = JSON.stringify(params)
	
	
	call_me_up    = exec 'python call_me.py \'' + moose + " \'", (error, stdout, stderr) ->
		console.log error
	
		resp.send stdout
	
	#resp.send moose

app.listen 2999