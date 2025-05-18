extends StaticBody2D # Ou o tipo de PhysicsBody2D que você está usando

## Caminho para o nó da porta que este cristal controla.
@export var no_porta_associada: NodePath
## Tempo em segundos que o cristal precisa ser iluminado para ativar a porta.
@export var tempo_para_ativar: float = 2.0

var porta_alvo: Node2D
var activation_timer: Timer
var porta_foi_desativada_pelo_cristal: bool = false

func _ready():
	if not no_porta_associada.is_empty():
		porta_alvo = get_node_or_null(no_porta_associada)

	# Configurar o Timer
	activation_timer = Timer.new()
	activation_timer.name = "ActivationTimerProgrammatic"
	activation_timer.wait_time = tempo_para_ativar
	activation_timer.one_shot = true
	activation_timer.autostart = false
	activation_timer.timeout.connect(_on_activation_timer_timeout)
	add_child(activation_timer)


## Chamado quando o ActivationTimer completa seu tempo.
func _on_activation_timer_timeout():
	if porta_alvo and not porta_foi_desativada_pelo_cristal: # Só desativa se ainda não foi
		print("Timer do cristal '%s' finalizado! DESATIVANDO PERMANENTEMENTE porta '%s'." % [name, porta_alvo.name])
		_executar_desativacao_porta()
		porta_foi_desativada_pelo_cristal = true # Marca que a porta foi desativada permanentemente
	elif not porta_alvo:
		printerr("Timer do cristal '%s' finalizado, mas a porta alvo não foi encontrada." % name)
	# Se porta_foi_desativada_pelo_cristal já for true, não faz nada.

func _executar_desativacao_porta():
	if not porta_alvo: return
	print("Executando desativação da porta: ", porta_alvo.name)
	porta_alvo.visible = false
	var colisao_porta = porta_alvo.get_node_or_null("CollisionShape2D") # Ajuste o nome se necessário
	if colisao_porta:
		colisao_porta.set_deferred("disabled", true)
	# if porta_alvo.has_method("abrir_porta_permanentemente"): porta_alvo.call("abrir_porta_permanentemente")


## Chamado pela lanterna quando este cristal começa a ser iluminado.
func comecou_a_ser_iluminado():
	print("Cristal '%s' começou a ser iluminado." % name)
	if not porta_alvo:
		printerr("Cristal '%s' iluminado, mas não há porta associada." % name)
		return

	# Se a porta ainda não foi desativada permanentemente por este cristal e o timer está parado, inicie o timer.
	if not porta_foi_desativada_pelo_cristal and activation_timer.is_stopped():
		print("Iniciando timer de ativação para o cristal '%s' (%.1f segundos)." % [name, activation_timer.wait_time])
		activation_timer.start()
	elif porta_foi_desativada_pelo_cristal:
		print("Cristal '%s' iluminado, mas a porta já está PERMANENTEMENTE desativada por ele." % name)
	elif not activation_timer.is_stopped():
		print("Cristal '%s' iluminado, mas o timer já está em contagem." % name)

## Chamado pela lanterna quando este cristal deixa de ser iluminado.
func parou_de_ser_iluminado():
	print("Cristal '%s' parou de ser iluminado." % name)
	if not porta_alvo:
		return

	# Se o timer estava rodando (porta ainda não desativada), pare o timer.
	# Isso cancela a "carga" se a luz for removida antes do tempo.
	if not activation_timer.is_stopped():
		print("Iluminação do cristal '%s' interrompida durante a carga. Parando timer." % name)
		activation_timer.stop()
	
	# >>> A PARTE DE REATIVAR A PORTA FOI REMOVIDA DAQUI <<<
	# Se a porta já foi desativada permanentemente (porta_foi_desativada_pelo_cristal == true),
	# não fazemos nada quando a luz é removida. A porta continua desativada.
	if porta_foi_desativada_pelo_cristal:
		print("Cristal '%s' não está mais iluminado, a porta permanece desativada." % name)
