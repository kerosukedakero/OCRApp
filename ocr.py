#use pyocr
from tkinter import Image
import pyocr
import pyocr.builders
import io
import os
import cv2

#use pyocr
tools = pyocr.get_available_tools()
if len(tools):
    tool = tools[0]
    #create Image 
    Image = Image.open('test.png')

    #convert Image to binary
    img = cv2.imreadI('test.png')

    txt = tool.image_to_string(Image.open('test.png'), lang='jpn', builder=pyocr.builders.TextBuillder())



#create class
class OCR:
    #create constructor
    def __init__(self):
        self.tools = pyocr.get_available_tools()
        self.tool = self.tools[0]
        self.lang = 'jpn'
        self.builder = pyocr.builders.TextBuilder()
        self.txt = self.tool.image_to_string(Image.open('test.png'), lang=self.lang, builder=self.builder)
        print(self.txt)

    #create method
    def get_text(self):
        return self.txt

    def get_text_from_image(self, image_path):
        return self.tool.image_to_string(Image.open(image_path), lang=self.lang, builder=self.builder)

    def get_text_from_binary(self, binary_image):
        return self.tools[0].image_to_string(Image.open(binary_image), lang=self.lang, builder=self.builder)

    def get_text_from_url(self, url):
        return self.tool.image_to_string(Image.open(url), lang=self.lang, builder=self.builder)


#create instance
ocr = OCR()

#use instance
ocr.get_text()

ocr.get_text_from_image('test.png')

ocr.get_text_from_binary('test.png')

ocr.get_text_from_url('test.png')


