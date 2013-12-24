(function() {
  var Stars;

  FW.Stars = Stars = (function() {
    var rnd;

    rnd = FW.rnd;

    function Stars() {
      this.colorStart = new THREE.Color();
      this.colorStart.setRGB(1, 1, 1);
      this.starGroup = new ShaderParticleGroup({
        texture: THREE.ImageUtils.loadTexture('assets/star.png'),
        blending: THREE.AdditiveBlending,
        maxAge: 100
      });
      this.colorEnd = new THREE.Color();
      this.generateStars();
      FW.scene.add(this.starGroup.mesh);
    }

    Stars.prototype.generateStars = function() {
      this.starEmitter = new ShaderParticleEmitter({
        type: 'sphere',
        radius: FW.width,
        speed: .1,
        size: rnd(800, 1200),
        sizeSpread: 400,
        particlesPerSecond: 500,
        opacityStart: 0,
        opacityMiddle: 1,
        opacityEnd: 0,
        colorStart: this.colorStart,
        colorEnd: this.colorEnd
      });
      return this.starGroup.addEmitter(this.starEmitter);
    };

    Stars.prototype.tick = function() {
      return this.starGroup.tick(0.16);
    };

    return Stars;

  })();

}).call(this);
