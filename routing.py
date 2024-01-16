from channels.routing import ProtocolTypeRouter, URLRouter
from django.urls import path
from django.core.asgi import get_asgi_application
from  AppRehabilitation.views  import RutinaLuxacionConsumer, RutinaLesionMediaConsumer
from channels.auth import AuthMiddlewareStack

application = ProtocolTypeRouter({
    'https':get_asgi_application(),
    
    'websocket': AuthMiddlewareStack(
        URLRouter([
        path('wss/rutina/luxacion/', RutinaLuxacionConsumer.as_asgi()),
        path('wss/rutina/lesion/media/', RutinaLesionMediaConsumer.as_asgi()),
        ]))
})