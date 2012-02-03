from django.conf import settings
from django.template import Context, Template
import sys
import json

##get the stuff sent from other languages
data_array 	= sys.argv[1]
data_array	= json.loads(data_array)


## open up the template
template_contents 	= open(data_array["settings"]["path"] + data_array["settings"]["render"], "r").read()

settings.configure(DEBUG=True)
settings.TEMPLATE_DIRS = [data_array["settings"]["path"]]

t	= Template(template_contents)

c 	= Context(data_array["context"]);

moose = t.render(c)

print moose