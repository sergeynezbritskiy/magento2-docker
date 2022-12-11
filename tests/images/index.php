<?php

$result = imagecreatefrompng(__DIR__ . DIRECTORY_SEPARATOR . 'image.png');
assert($result instanceof GdImage, 'imagecreatefrompng doesn\'t work properly');

$result = imagecreatefromjpeg(__DIR__ . DIRECTORY_SEPARATOR . 'image.jpg');
assert($result instanceof GdImage);

$result = imagecreatefromwebp(__DIR__ . DIRECTORY_SEPARATOR . 'image.webp');
assert($result instanceof GdImage);
