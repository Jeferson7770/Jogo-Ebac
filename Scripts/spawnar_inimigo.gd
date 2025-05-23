# zona_de_ativacao.gd
extends Area2D

## Caminho para o nó do inimigo que esta zona deve ativar.
@export var no_inimigo_para_ativar: NodePath

var inimigo_alvo: Node # Espera-se que seja o CharacterBody2D do inimigo
var ja_ativou: bool = false

func _ready():
	if not no_inimigo_para_ativar.is_empty():
		inimigo_alvo = get_node_or_null(no_inimigo_para_ativar)
	
	if not inimigo_alvo:
		printerr("ZonaDeAtivacao '%s': Inimigo não encontrado ou caminho não definido! Caminho: %s" % [name, no_inimigo_para_ativar])
	elif not inimigo_alvo.has_method("set_paralyzed"):
		# Verifica se o inimigo realmente tem o método que queremos chamar
		printerr("ZonaDeAtivacao '%s': O inimigo alvo '%s' NÃO POSSUI o método 'set_paralyzed(bool)'." % [name, inimigo_alvo.name])
		inimigo_alvo = null # Invalida o alvo para evitar erros futuros
	else:
		pass

	self.body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D):
	# Se já ativou ou não há um inimigo válido configurado, não faz nada
	if ja_ativou or not inimigo_alvo:
		return

	# Verifica se o corpo que entrou na área pertence ao grupo "jogador"
	if body.is_in_group("player"): # Certifique-se que seu jogador está no grupo "jogador"
		print("Jogador entrou na zona de ativação: " + name)
		
		# Ativa o inimigo (desparalisa)
		# A verificação de has_method já foi feita em _ready, mas pode ser mantida por segurança
		if inimigo_alvo.has_method("set_paralyzed"):
			inimigo_alvo.call("set_paralyzed", false) # Chama o método para desparalisar
			
			ja_ativou = true # Marca que este gatilho já foi usado
