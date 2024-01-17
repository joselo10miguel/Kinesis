from AppRehabilitation.views import RutinaLuxacionConsumer,RutinaLesionMediaConsumer
from django.urls import re_path

websocket_urlpatterns = [
    re_path(r"rutina/luxacion/", RutinaLuxacionConsumer.as_asgi()),
     re_path(r"rutina/lesion/media/", RutinaLesionMediaConsumer.as_asgi()),
]



