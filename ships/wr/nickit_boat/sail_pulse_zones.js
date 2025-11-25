const fs = require('fs');
const fsp = fs.promises;
const { createCanvas, loadImage } = require('canvas');

const frames = 28;
const file = "sail_pulse_source.png";


(async function () {
    const sourceImage = await loadImage(file);
    let sourceCanvas = createCanvas(sourceImage.width, sourceImage.height);
    let sctx = sourceCanvas.getContext('2d');
    sctx.drawImage(sourceImage, 0, 0);
    let outputCanvas = createCanvas(sourceImage.width, sourceImage.height);
    let outtx = outputCanvas.getContext('2d');
    outtx.globalCompositeOperation = 'destination-over'
    const frameHeight = sourceImage.height / frames;


    async function outputSailZone(mask, frameOffset, color) {
        const maskImage = await loadImage(mask);
        for (let i = 0; i < frames; i++) {
            let curFrameIndex = (i + frameOffset) % frames;
            let curFrameCanvas = createCanvas(maskImage.width, maskImage.height);
            let curFrametx = curFrameCanvas.getContext('2d')
            curFrametx.putImageData(sctx.getImageData(0, curFrameIndex * frameHeight, sourceImage.width, frameHeight), 0, 0);
            curFrametx.globalCompositeOperation = 'destination-in';
            curFrametx.drawImage(maskImage, 0, 0);
            curFrametx.globalCompositeOperation = 'source-in'
            curFrametx.fillStyle = color;
            curFrametx.fillRect(0, 0, maskImage.width, maskImage.height);
            outtx.drawImage(curFrameCanvas, 0, i * frameHeight);
        }
    }
    await outputSailZone("sail_zone1.png", 0, "hsl(326, 100%, 50.00%)");
    await outputSailZone("sail_zone2.png", 2, "hsl(348, 100%, 50.00%)");
    await outputSailZone("sail_zone3.png", 4, "hsl(19, 100%, 50.00%)");
    await outputSailZone("sail_zone4.png", frames - 2, "hsl(294, 100%, 50.00%)");
    await outputSailZone("sail_zone5.png", 12, "hsl(204, 100%, 50.00%)");
    outputCanvas.createPNGStream().pipe(fs.createWriteStream("sail_pulse.png"));

})();
