from PIL import Image, ImageOps
import os

def make_square(image):
    x, y = image.size
    size = min(x, y)
    left = (x - size) // 2
    top = (y - size) // 2
    right = (x + size) // 2
    bottom = (y + size) // 2
    new_image = image.crop((left, top, right, bottom))
    return new_image

def process_images(input_folder):
    for filename in os.listdir(input_folder):
        if filename.endswith(('.png', '.jpg', '.jpeg')):
            image_path = os.path.join(input_folder, filename)
            image = Image.open(image_path)
            square_image = make_square(image)
            square_image.save(image_path)

if __name__ == "__main__":
    input_folder = 'city'
    process_images(input_folder)