express 			= require "express"
child_proc  		= require('child_process')
app					= express.createServer()

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

	json_string = JSON.stringify(params)
	json_buffer = new Buffer json_string
	#json_string = encodeURIComponent(json_string)
	
	python_child = child_proc.spawn "python" , ["python_bind.py"]
	
	python_child.stdin.write(json_buffer)
	python_child.stdin.end()
	
	python_child.stderr.on "data", (data) ->
		resp.send data.toString()
	
	python_child.stdout.on "data", (data) ->
		resp.send data.toString()
	
app.listen 2999