import image
import pyglet
from pyglet.window import key
import json
from copy import copy

class Zoomer:
    numpad_keys = (65457,
                   65458,
                   65459,
                   65460,
                   65461,
                   65462,
                   65463,
                   65464,
                   65465,
                   65288)

    def __init__(self):
        self.load_config()
        window = pyglet.window.Window(height=self.config['image']['height'],
                                      width=self.config['image']['width'])
        self.window = window
        self.generate_image()

        @window.event
        def on_draw():
            self.window.clear()
            img = pyglet.resource.image('img/' + self.config['image']['file_name'])
            img.blit(0,0)

        @window.event
        def on_key_press(symbol, modifiers):
            if symbol in Zoomer.numpad_keys:
                key = Zoomer.numpad_keys.index(symbol) + 1
                self.zoom(key)
                self.generate_image()
            else:
                print('Unrecognized key: {} type: {}'.format(symbol, type(symbol)))

        pyglet.app.run()

    def zoom(self, n):
        if n == 10:
            self.limits = copy(self.config['limits'])
            return
        real_step = (self.limits['rhi'] - self.limits['rlo']) / 3
        imag_step = (self.limits['ihi'] - self.limits['ilo']) / 3

        x = 2 - (n-1) // 3
        y = (n-1) % 3

        self.limits['rlo'] += x * real_step
        self.limits['rhi'] = self.limits['rlo'] + real_step
        self.limits['ilo'] += y * imag_step
        self.limits['ihi'] = self.limits['ilo'] + imag_step

    def load_config(self):
        with open('config.json', 'r') as myfile:
            self.config = json.load(myfile)
        self.limits = copy(self.config['limits'])

    @property
    def c(self):
        return complex(self.config['complex']['real'],
                       self.config['complex']['imag'])

    def generate_image(self):
        image_settings = (self.config['image']['height'],
                          self.config['image']['width'],
                          self.config['image']['max_depth'],
                          self.config['image']['file_name'],
                          self.c,
                          float(self.limits['rlo']),
                          float(self.limits['ilo']),
                          float(self.limits['rhi']),
                          float(self.limits['ihi']))
        result = image.make_image(*image_settings)
