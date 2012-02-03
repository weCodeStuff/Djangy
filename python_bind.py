from django.conf import settings
from django.template import Context, Template
import sys
import json

settings.configure(DEBUG=True)

if __name__ == "__main__":
	##get the stuff sent from other languages
	data_array 	= sys.argv[1]
	data_array	= json.loads(data_array)
	
	
	## open up the template
	settings.TEMPLATE_DIRS 	= [data_array["settings"]["path"]]
	template_contents 		= open(data_array["settings"]["path"] + data_array["settings"]["render"], "r").read()
	
	t	= Template(template_contents)
	c 	= Context(data_array["context"]);
	
	print t.render(c)