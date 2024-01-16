import json
from channels.generic.websocket import AsyncWebsocketConsumer

class VideoConsumer(AsyncWebsocketConsumer):
    async def connect(self):
        await self.accept()

    async def disconnect(self, close_code):
        pass

    async def receive(self, text_data):
        # Puedes procesar comandos enviados desde el frontend si es necesario
        pass

    async def send_frame(self, frame):
        await self.send(text_data=json.dumps({'frame': frame.decode('utf-8')}))