express 	= require "express"
exec  = require('child_process').exec
app			= express.createServer()

django_templates = require "django_templates"

express.view.register('.html', django_templates)
app.set('views', __dirname + '/templates');
app.set("view options", { layout: false })

app.get '/', (req, resp) ->

	params 	= {}
	params["settings"]	= {}
	params["context"]	= {}
	
	params["settings"]["path"]				= __dirname + "/templates/"
	params["settings"]["render"]			= "index.html"
	
	params["context"]["sexi_stuff"]			= "moose"
	params["context"]["make_me_awesome"]	= "Wtf_yo"

	moose = JSON.stringify(params)
	
	console.log 'python python_bind.py \'' + moose + " \'"
	
	call_me_up    = exec 'python python_bind.py \'' + moose + " \'", (error, stdout, stderr) ->
		console.log error
	
		resp.send stdout
	
	#resp.send moose
	
	
	#resp.render "index.html", {"yo": "dawg"}
	
app.listen 2999