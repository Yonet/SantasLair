FW.Tree = class Tree
  rnd = FW.rnd
  constructor: (pos)->
    @position = pos
    @treeGroup = new ShaderParticleGroup({
      texture: THREE.ImageUtils.loadTexture('assets/leaf.png')
      maxAge: 100
      blending: THREE.NormalBlending
    });

    @ornamentGroup = new ShaderParticleGroup({
      texture: THREE.ImageUtils.loadTexture('assets/star.png')
      maxAge: 100
      blending: THREE.NormalBlending
    });

    height = rnd(30, 60)
    for y in [1..50]
      position = new THREE.Vector3 rnd(@position.x-10, @position.x+10), y*4,  @position.z
      @treeGroup.addEmitter @generateTree(y, position)
      # @ornamentGroup.addEmitter @generateOrnaments(y)
    FW.scene.add(@treeGroup.mesh)

  generateTree: (y)->
    spread = 250 - y*5
    treeEmitter = new ShaderParticleEmitter
      size: 200
      sizeSpread: 50
      position: new THREE.Vector3 @position.x,  y*4, rnd(@position.z-100, @position.z+100)
      #As we go higher, we want spread less to give xmas tree pyramid shape
      positionSpread: new THREE.Vector3 spread * rnd(0.9, 1) , 0, spread * rnd(0.9, 1)
      particlesPerSecond: 10/y
      opacityStart: 1.0
      opacityMiddle: 1.0
      opacityEnd: 1.0
  
  generateOrnaments: (y)->
    spread = 250 - y*5
    ornamentEmmiter = new ShaderParticleEmitter
      size: 100
      sizeSpread: 50



  
    
  tick: ->
    # @treeGroup.tick(FW.globalTick/10)
    @treeGroup.tick(FW.globalTick)
    


