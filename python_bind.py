from django.conf import settings
from django.template import Context, Template
import sys
import json

settings.configure(DEBUG=False)

if __name__ == "__main__":
	##get the stuff sent from other languages
	data_array 	= sys.argv[1]
	data_array	= json.loads(data_array)
	
	if "debug_mode" in data_array["settings"] and data_array["settings"]["debug_mode"]:
		settings.DEBUG = True
	
	## open up the template
	settings.TEMPLATE_DIRS 	= [data_array["settings"]["path"]]
	template_contents 		= open(data_array["settings"]["path"] + data_array["settings"]["render"], "r").read()
	
	try:
		t	= Template(template_contents)
	except Exception,e:	
		print e
		sys.exit()
		
	c 	= Context(data_array["context"])
	
	try:
		print t.render(c)
		sys.exit()
	except Exception,e:
		print e
		sys.exit()
		