const ImageSet = document.querySelectorAll('.imageset');
let currentIndex = 0;
function showNextImage() {
    ImageSet[currentIndex].style.opacity = 0;
    currentIndex = (currentIndex + 1) % ImageSet.length;
    ImageSet[currentIndex].style.opacity = 1;
}
setInterval(showNextImage, 2500); // 每隔3秒切换一张图片


