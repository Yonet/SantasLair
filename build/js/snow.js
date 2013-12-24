(function() {
  var Snow;

  FW.Snow = Snow = (function() {
    var rnd;

    rnd = FW.rnd;

    function Snow() {
      this.snowGroup = new ShaderParticleGroup({
        texture: THREE.ImageUtils.loadTexture('assets/smokeparticle.png'),
        maxAge: 50
      });
      this.snowGroup.addEmitter(this.generateSnow());
      FW.scene.add(this.snowGroup.mesh);
      this.snowGroup.mesh.renderDepth = -2;
    }

    Snow.prototype.generateSnow = function() {
      var colorStart, snowEmitterSettings;
      colorStart = new THREE.Color();
      colorStart.setRGB(1, 1, 1);
      return snowEmitterSettings = new ShaderParticleEmitter({
        size: 1000,
        sizeEnd: 250,
        position: new THREE.Vector3(0, FW.width * 0.7, 0),
        positionSpread: new THREE.Vector3(FW.width * 0.95, 2000, FW.width * 0.95),
        colorStart: colorStart,
        colorEnd: colorStart,
        velocity: new THREE.Vector3(0, -100, 0),
        acceleration: new THREE.Vector3(0, -0.5, 0),
        accelerationSpread: new THREE.Vector3(1, .1, 1),
        particlesPerSecond: 50,
        opacityEnd: 1
      });
    };

    Snow.prototype.tick = function() {
      return this.snowGroup.tick(FW.globalTick);
    };

    return Snow;

  })();

}).call(this);
