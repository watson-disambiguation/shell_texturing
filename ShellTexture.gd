extends Node3D

@export var color: Color
@export var numLayers: int = 32;
@export var height: float = 0.1
@export var shellTextureShader: Shader
@export var model: Mesh

var layers: Array[MeshInstance3D]

# Called when the node enters the scene tree for the first time.
func _ready():
	layers = []
	
	for i in range(0,numLayers+1):
		var range: float =  float(i) / float(numLayers-1);
		var threshold: float = 1 - range
		var mesh = MeshInstance3D.new()
		mesh.mesh = model
		# position modification for test
		mesh.position = position + Vector3.UP * range * height
		var material: ShaderMaterial = ShaderMaterial.new()
		mesh.set_surface_override_material(0,material)
		print_debug(mesh.get_surface_override_material(0))
		material.shader = shellTextureShader;
		material.set_shader_parameter("threshold",threshold)
		material.set_shader_parameter("strands",100)
		material.set_shader_parameter("color",color)
		add_child(mesh)
	
	
	

