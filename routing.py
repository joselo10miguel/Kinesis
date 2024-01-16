from channels.routing import ProtocolTypeRouter, URLRouter
from django.urls import path
from django.core.asgi import get_asgi_application
from  AppRehabilitation.views  import RutinaLuxacionConsumer, RutinaLesionMediaConsumer
from channels.auth import AuthMiddlewareStack
from channels.security.websocket import AllowedHostsOriginValidator


application = ProtocolTypeRouter({
    # Django's ASGI application to handle traditional HTTP requests
    "http": get_asgi_application,
    "https": get_asgi_application,

    # WebSocket chat handler
    "websocket": AllowedHostsOriginValidator(
        AuthMiddlewareStack(
            URLRouter([
                 path('wss/rutina/luxacion/', RutinaLuxacionConsumer.as_asgi()),
                 path('wss/rutina/lesion/media/', RutinaLesionMediaConsumer.as_asgi()),
            ])
        )
    ),
})