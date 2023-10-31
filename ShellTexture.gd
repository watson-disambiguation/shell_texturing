extends Node3D

@export var color: Color
@export var numLayers: int = 32;
@export var strands: int = 100
@export var height: float = 0.1
@export var shellTextureShader: Shader
@export var model: Mesh

var layers: Array[MeshInstance3D]

# Called when the node enters the scene tree for the first time.
func _ready():
	layers = []
	
	for i in range(0,numLayers+1):
		var range: float =  float(i) / float(numLayers-1);
		var threshold: float = range
		var mesh = MeshInstance3D.new()
		mesh.mesh = model

		var material: ShaderMaterial = ShaderMaterial.new()
		mesh.set_surface_override_material(0,material)
		material.shader = shellTextureShader;
		material.set_shader_parameter("threshold",threshold)
		material.set_shader_parameter("strands",float(strands))
		material.set_shader_parameter("color",color)
		material.set_shader_parameter("height",range * height)
		add_child(mesh)
	
	
	


