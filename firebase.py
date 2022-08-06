from urllib import response
from PIL import Image
import pyocr
from firebase_admin import credentials, firestore, initialize_app , storage
import urllib.request
from urllib.parse import urlparse
import requests


#Firebase認証
cred = credentials.Certificate(".json")
initialize_app(cred, {'storageBucket': 'gs://hogehoge.appspot.com'})

bucket = storage.bucket('hogehoge.appspot.com')

#アップロード用
filenameup = 'upload.jpg'

path = ''

filenamedown = "Item"

#urlクエリパラメータ
#urlクエリパラメータ
q_data = {
    'q': 'Pythonでクエリパラメータを作成',
    'option': [1, 3, 5],
    'lang': 'jp',
}


#アップロード
def upload_blob(filenameup, path):
    blob = bucket.blob(filenameup)
    blob.upload_from_filename(path + filenameup)
    blob.make_public()
    print(blob.public_url)  

#ダウンロード
def download_blob(filenamedown, path):
    blob = bucket.blob(filenamedown)
    blob.download_to_filename(path + filenamedown)
    blob.make_public()
    print(blob.public_url) 
    # qs = urlencode(q_data)
    # firebasedownloadurl = blob.public_url + qs
    # print(firebasedownloadurl)
    urllib.request.urlretrieve(blob.public_url)
    print("ダウンロード完了")

#コミットのためにコメント書く

#実行
if __name__ == '__main__':
    download_blob(filenamedown,path)


#urlから画像を保存する
url = "画像のURL"
file_name = ""

response = requests.get(url)
image = response.content

with open(file_name, 'wb') as f: 
    f.write(image)

#urlで保存した画像を読み込む
img = Image.open(file_name)
img.show()


#pyocrを利用したOCR
tools = pyocr.get_available_tools()
tool = tools[0]

txt = tool.image_to_string(Image.open('test.png'), lang='jpn', builder=pyocr.builders.TextBuilder())


print(txt)