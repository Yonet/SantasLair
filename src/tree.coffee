FW.Tree = class Tree
  rnd = FW.rnd
  constructor: (pos, scaleFactor)->
    @ornamentMaxAge = 1
    @ornamentsMovingUp = true
    @position = pos
    @scaleFactor = scaleFactor
    @treeTick = 2
    @ornamentGroups = []
    @ornamentTick = .05
    @numLayers = 10
    @heightFactor = 25
    @squishFactor = 24
    @currentLightLayer   = 0
    @treeGroup = new ShaderParticleGroup({
      texture: THREE.ImageUtils.loadTexture('assets/leaf2.png')
      maxAge: 10
      blending: THREE.NormalBlending
    });
    
    for curHeightLayer in [1..@numLayers]
      @treeGroup.addEmitter @generateTree(curHeightLayer)
      @createOrnamentGroup(curHeightLayer)
    FW.scene.add(@treeGroup.mesh)
    @treeGroup.mesh.scale.set(@scaleFactor, @scaleFactor, @scaleFactor)
    setTimeout(()=>
      @activateOrnamentLayer()
    rnd(1000, 5000))



  
  
  ##########################################
  #TICK MAIN LOOOOP

  tick: ->
    if @treeTick > 0.0
      @treeGroup.tick(@treeTick)
      @treeTick -=.1
    if @treeTick < .0
      @treeTick = 0.0
    for ornamentGroup in @ornamentGroups
      ornamentGroup.tick(@ornamentTick)
    

  activateOrnamentLayer: ()->
    setTimeout(()=>
      if @ornamentsMovingUp
        if @currentLightLayer < @ornamentGroups.length
          @ornamentGroups[@currentLightLayer++].triggerPoolEmitter(1)
        #We've reached top of tree, now go back down
        else if @currentLightLayer is @ornamentGroups.length
          @ornamentsMovingUp = false
          @currentLightLayer--
      else if not @ornamentsMovingUp
        if @currentLightLayer >= 0
          @ornamentGroups[@currentLightLayer--].triggerPoolEmitter(1)
        # We've reached bottom of trees, now move back up
        else if @currentLightLayer < 0
          @ornamentsMovingUp = true 
          @currentLightLayer++
      @activateOrnamentLayer()
    50)


  createOrnamentGroup: (curHeightLayer)->
      ornamentGroup = new ShaderParticleGroup(
        texture: THREE.ImageUtils.loadTexture('assets/star.png')
        maxAge: @ornamentMaxAge
        blending: THREE.AdditiveBlending
      )

      ornamentGroup.addPool 2, @generateOrnaments(curHeightLayer), false
      @ornamentGroups.push ornamentGroup
      ornamentGroup.mesh.scale.set(@scaleFactor, @scaleFactor, @scaleFactor)
      FW.scene.add ornamentGroup.mesh
      ornamentGroup.mesh.renderDepth = -1


  generateOrnaments: (curHeightLayer)->
    spread = Math.max 0, 250 - curHeightLayer * @squishFactor
    colorStart = new THREE.Color()
    colorStart.setRGB(Math.random(), Math.random(), Math.random())
    ornamentEmmiterSettings = 
      size: 200 * @scaleFactor
      sizeSpread: 200
      sizeEnd: 20
      colorStart: colorStart
      colorSpread: new THREE.Vector3(0.2, 0.2, 0.2)
      colorEnd: colorStart
      position: new THREE.Vector3 @position.x, curHeightLayer*@heightFactor, @position.z
      positionSpread: new THREE.Vector3 spread+5, 10, spread+ 5
      particlesPerSecond: 100/curHeightLayer
      opacityStart: 1.0
      opacityMiddle: 1.0
      opacityEnd: 1.0
      alive: 0
      emitterDuration: 1
    return ornamentEmmiterSettings

  generateTree: (curHeightLayer)->
    spread = Math.max 0, 250 - curHeightLayer* @squishFactor
    @treeEmitter = new ShaderParticleEmitter
      size: 200 * @scaleFactor
      sizeEnd: 100
      position: new THREE.Vector3 @position.x,  curHeightLayer*@heightFactor, @position.z
      #As we go higher, we want spread less to give xmas tree pyramid shape
      positionSpread: new THREE.Vector3 spread , 10, spread
      colorEnd: new THREE.Color()
      particlesPerSecond: 25.0/ curHeightLayer
      opacityEnd: 1.0




