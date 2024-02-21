import Foundation
import SpriteKit

var posicoes_2: [CGPoint] = []

class GameSceneLevel2: SKScene, SKPhysicsContactDelegate {
    
    var showNextPhaseSheet = false {
        didSet { didFinishGame(showNextPhaseSheet)
            
        }
    }
    var didFinishGame:(Bool)->Void = {_ in}
    
    lazy var resp1_2: SKSpriteNode = {
        let resp1_2 = SKSpriteNode(imageNamed: "left-arrow")
        resp1_2.position.y = self.frame.maxY - resp1_2.size.height/2
        resp1_2.position.x = -(resp1_2.size.width * 2)
        resp1_2.name = "resp1"

        return resp1_2
    }()
    
    lazy var resp2_2: SKSpriteNode = {
        let resp2 = SKSpriteNode(imageNamed: "up-arrow-button")
        resp2.position.y = self.frame.maxY - resp2.size.height/2
        resp2.position.x = -(resp2.size.width)
        resp2.name = "resp2"

        return resp2
    }()
    
    lazy var resp3_2: SKSpriteNode = {
        let resp3 = SKSpriteNode(imageNamed: "down-arrow")
        resp3.position.y = self.frame.maxY - resp3.size.height/2
        resp3.name = "resp3"

        return resp3
    }()
    
    lazy var resp4_2: SKSpriteNode = {
        let resp4 = SKSpriteNode(imageNamed: "right-arrow")
        resp4.position.y = self.frame.maxY - resp4.size.height/2
        resp4.position.x = (resp4.size.width)
        resp4.name = "resp4"

        return resp4
    }()
    
    lazy var stop: SKSpriteNode = {
        let stop = SKSpriteNode(imageNamed: "stop-block-game")
        stop.position.y = self.frame.maxY - stop.size.height/2
        stop.position.x = (stop.size.width * 2)
        stop.name = "stop"

        return stop
    }()
    
    lazy var ifSquare: SKSpriteNode = {
        let ifSquare = SKSpriteNode(imageNamed: "if-block-game")
        ifSquare.position.y = self.frame.maxY - (ifSquare.size.height * 1.5) - 20
        ifSquare.position.x = -(ifSquare.size.width * 1.5 + 15)
        ifSquare.name = "ifSquare"

        return ifSquare
    }()
    
    lazy var answerSquare1_2: SKSpriteNode = {
        let answerSquare1_2 = SKSpriteNode(imageNamed: "answer-square_2")
        answerSquare1_2.position.y = self.frame.maxY - (ifSquare.size.height * 2) - 20
        answerSquare1_2.position.x = -(elseSquare.size.width + answerSquare1_2.size.width/2 + 15)
        answerSquare1_2.name = "answerSquare1_2"

        return answerSquare1_2
    }()
    
    lazy var appleIn: SKSpriteNode = {
        let appleIn = SKSpriteNode(imageNamed: "apple-in-square-game")
        appleIn.position.y = self.frame.maxY - (appleIn.size.height * 1.5) - 20
        appleIn.position.x = -(appleIn.size.width/2 + 5)
        appleIn.name = "appleIn"

        return appleIn
    }()
    
    lazy var doSquare: SKSpriteNode = {
        let doSquare = SKSpriteNode(imageNamed: "do-block-game")
        doSquare.position.y = self.frame.maxY - (doSquare.size.height * 1.5) - 20
        doSquare.position.x = (doSquare.size.width/2 + 5)
        doSquare.name = "doSquare"

        return doSquare
    }()
    
    lazy var answerSquare2_2: SKSpriteNode = {
        let answerSquare2_2 = SKSpriteNode(imageNamed: "answer-square_2")
        answerSquare2_2.position.y = self.frame.maxY - (doSquare.size.height * 1.5) - 20
        answerSquare2_2.position.x = (answerSquare2_2.size.width * 1.5 + 15)
        answerSquare2_2.name = "answerSquare2_2"

        return answerSquare2_2
    }()
    
    lazy var elseSquare: SKSpriteNode = {
        let elseSquare = SKSpriteNode(imageNamed: "else-block-game")
        elseSquare.position.y = self.frame.maxY - (elseSquare.size.height * 2.5) - 30
        elseSquare.position.x = -(elseSquare.size.width/2 + 5)
        elseSquare.name = "elseSquare"

        return elseSquare
    }()
    
    lazy var answerSquare3_2: SKSpriteNode = {
        let answerSquare3_2 = SKSpriteNode(imageNamed: "answer-square_2")
        answerSquare3_2.position.y = self.frame.maxY - (elseSquare.size.height * 2.5) - 30
        answerSquare3_2.position.x = (answerSquare3_2.size.width/2 + 5)
        answerSquare3_2.name = "answerSquare3_2"

        return answerSquare3_2
    }()
    
    lazy var answerSquare4_2: SKSpriteNode = {
        let answerSquare4_2 = SKSpriteNode(imageNamed: "answer-square_2")
        answerSquare4_2.position.y = self.frame.maxY - (elseSquare.size.height * 2.5) - 30
        answerSquare4_2.position.x = (answerSquare4_2.size.width * 1.5 + 15)
        answerSquare4_2.name = "answerSquare4_2"

        return answerSquare4_2
    }()
    
    lazy var answerSquare5_2: SKSpriteNode = {
        let answerSquare5_2 = SKSpriteNode(imageNamed: "answer-square_2")
        answerSquare5_2.position.y = self.frame.maxY - (ifSquare.size.height * 2) - 20
        answerSquare5_2.position.x = (answerSquare5_2.size.width * 2.5 + 25)
        answerSquare5_2.name = "answerSquare5_2"

        return answerSquare5_2
    }()
    
    lazy var board: SKSpriteNode = {
        let board = SKSpriteNode(imageNamed: "tabuleiro")
        board.name = "board"
        board.position.y = ((answerSquare4_2.position.y - answerSquare4_2.size.height/2) + self.frame.minY) / 2

        return board
    }()
    
    lazy var snake: SKSpriteNode = {
        let snake = SKSpriteNode(imageNamed: "snake")
        snake.name = "snake"
        snake.position.x = -((board.size.width/2) + (snake.size.width/2))
        
        snake.physicsBody = SKPhysicsBody(texture: snake.texture!, size: snake.size)
        snake.physicsBody?.affectedByGravity = false
        snake.physicsBody?.isDynamic = false
        
        snake.physicsBody?.categoryBitMask =  1
        snake.physicsBody?.contactTestBitMask = 1
        snake.physicsBody?.collisionBitMask =  1

        return snake
    }()
    
    lazy var exit: SKSpriteNode = {
        let exit = SKSpriteNode(imageNamed: "placa-exit-deitada")
        exit.name = "exit"
        exit.position.x = ((board.size.width/2) + (exit.size.width/2) + 10)
        exit.zPosition = -1

        return exit
    }()
    
    lazy var apple: SKSpriteNode = {
        let apple = SKSpriteNode(imageNamed: "apple-game")
        
        apple.position.y = self.board.size.height/3
        
        apple.physicsBody = SKPhysicsBody(texture: apple.texture!, size: apple.size)
        apple.physicsBody?.affectedByGravity = false
        apple.physicsBody?.isDynamic = true
        apple.physicsBody?.allowsRotation = false

        apple.physicsBody?.categoryBitMask =  1
        snake.physicsBody?.contactTestBitMask = 1
        snake.physicsBody?.collisionBitMask =  1
        
        apple.name = "apple-game"
        
        let desceMeio = SKAction.moveTo(y: 0, duration: 0.75)
        let atualizaPosDesceMeio = SKAction.run {
            apple.position = CGPoint(x: 0, y: 0)
        }
        
        let desceTudo = SKAction.moveTo(y: -board.size.height/3, duration: 0.75)
        let atualizaPosDesceTudo = SKAction.run {
            apple.position = CGPoint(x: 0, y: -self.board.size.height/3)
        }
        
        let sobeMeio = SKAction.moveTo(y: 0, duration: 0.75)
        let atualizaPosSobeMeio = SKAction.run {
            apple.position = CGPoint(x: 0, y: 0)
        }
        
        let sobeTudo = SKAction.moveTo(y: board.size.height/3, duration: 0.75)
        let atualizaPosSobeTudo = SKAction.run {
            apple.position = CGPoint(x: 0, y: self.board.size.height/3)
        }
        
        let espera = SKAction.wait(forDuration: 1.0)
        let esperaBorda = SKAction.wait(forDuration: 0.5)
    
        
        let sequencia = SKAction.sequence([desceMeio, atualizaPosDesceMeio, espera, desceTudo, atualizaPosDesceTudo, espera, sobeMeio, atualizaPosSobeMeio, espera, sobeTudo, atualizaPosSobeTudo, espera])
        let loop = SKAction.repeatForever(sequencia)
        apple.run(loop)

        return apple
    }()
    
    lazy var fences: SKNode = {
        let fences = SKNode()
        
        let fence1 = SKSpriteNode(imageNamed: "fence")
        fence1.name = "fence1"
        fence1.position.y = board.size.height/3
        
        let fence2 = SKSpriteNode(imageNamed: "fence")
        fence2.name = "fence2"
        fence2.position.y = -board.size.height/3
        
        fences.addChild(fence1)
        fences.addChild(fence2)
        
        fences.position.x = board.size.width/2 + 30

        return fences
    }()
    
    lazy var giveAnswer: SKSpriteNode = {
        let giveAnswer = SKSpriteNode(imageNamed: "locked-answer")
        giveAnswer.position.y = self.frame.maxY - (ifSquare.size.height * 2) - 20
        giveAnswer.position.x = (answerSquare5_2.size.width * 4 + 10)
        giveAnswer.name = "giveAnswer"

        return giveAnswer
    }()
    
    var respostasUsuario: [String] = ["", "", "", "", ""]
    
    var respostasUsuarioNodes: [SKSpriteNode] = []
    
    var vetorResps = ["resp1", "resp2", "resp3", "resp4", "stop"]
    
    var vetorGabarito = ["resp4", "resp4", "stop", "resp4", "resp4"]
    
    var todasResps: Bool = false
    
    var respEnviada: Bool = false
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity.dy = -1
        
        board.removeAllChildren()
        self.removeAllChildren()
        
        self.backgroundColor = UIColor(hex: "0F6B00")
        
        respostasUsuario = ["", "", "", "", ""]
        
        respostasUsuarioNodes = [resp1_2, resp2_2, resp3_2, resp4_2, stop]
        
        addChild(resp1_2)
        
        addChild(resp2_2)
        
        addChild(resp3_2)
        
        addChild(resp4_2)
        
        addChild(stop)
        
        addChild(answerSquare1_2)
        
        addChild(ifSquare)
        
        addChild(appleIn)
        
        addChild(doSquare)
        
        addChild(answerSquare2_2)
        
        addChild(elseSquare)
        
        addChild(answerSquare3_2)
        
        addChild(answerSquare4_2)
        
        addChild(answerSquare5_2)
        
        addChild(giveAnswer)
        giveAnswer.removeAllActions()
        giveAnswer.texture = SKTexture(imageNamed: "locked-answer")
        
        addChild(board)
        
        posicoes_2.append(answerSquare1_2.position)
        
        posicoes_2.append(answerSquare2_2.position)
        
        posicoes_2.append(answerSquare3_2.position)
        
        posicoes_2.append(answerSquare4_2.position)
        
        posicoes_2.append(answerSquare5_2.position)
        
        board.addChild(snake)
        
        board.addChild(apple)
        
        board.addChild(fences)
        
        board.addChild(exit)
        
        todasResps = false
        
        respEnviada = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touchedNode = getTouchedNode(touches) {
            
            // Se o nó clicado esta nas opcoes de resposta
            if touchedNode.position.y >= (self.frame.maxY - resp1_2.size.height/2 - 10) {
                // add o nome ao array, para dps comparar a resposta dada com o gabarito
                for i in 0..<5 {
                    respEnviada = false
                    // Pega a primeira posicao com uma string vazia
                    if respostasUsuario[i] == "" {
                        // cria uma copia do node clicado
                        let newNode = touchedNode.copy() as! SKSpriteNode
                        newNode.position = touchedNode.position
                        newNode.name = touchedNode.name
                        addChild(newNode)
                        respostasUsuarioNodes[i] = newNode
                        
                        respostasUsuario[i] = touchedNode.name!
                        
                        let targetPosition = posicoes_2[i] // Altere para a posição desejada
                        
                        // Inicia a animação para mover o novo nó para uma posição específica
                        let moveAction = SKAction.move(to: targetPosition, duration: 0.3)
                        newNode.run(moveAction)
                        
                        newNode.run(SKAction.playSoundFileNamed("card-slide.wav", waitForCompletion: false))
                        
                        // caso todas as respostas tenham sido dadas, libera o envio para correcao
                        if !respostasUsuario.contains("") {
                            giveAnswer.texture = SKTexture(imageNamed: "answer")
                            let aumentaResposta = SKAction.scale(to: 1.20, duration: 0.5)
                            let diminuiResposta = SKAction.scale(to: 1, duration: 0.5)
                            let sequenciaResp = SKAction.sequence([aumentaResposta, diminuiResposta])
                            let repeticao = SKAction.repeatForever(sequenciaResp)
                            giveAnswer.run(repeticao)
                            todasResps = true
                        }
                        break
                    }
                }
            }
            
            else {
                let nodeName = touchedNode.name!
                
                // Resposta está sendo retirada
                if vetorResps.contains(nodeName) && touchedNode.position.y <= answerSquare2_2.position.y {
                    // remove a resposta da lista, substituindo por uma string vazia
                    for i in 0..<5 {
                        if posicoes_2[i] == touchedNode.position {
                            respostasUsuario[i] = ""
                            respostasUsuarioNodes[i] = resp1_2
                        }
                    }
                    retiraResposta(respostaRetirada: touchedNode as! SKSpriteNode)
                    giveAnswer.removeAllActions()
                    giveAnswer.texture = SKTexture(imageNamed: "locked-answer")
                    todasResps = false
                }
                // Resposta sendo enviada
                else if touchedNode.name == "giveAnswer" && todasResps && !respEnviada {
                    respEnviada = true
                    comparaGabarito()
                }
            }
        }
    }
    
    func comparaGabarito() {
        for i in 0..<5 {
            // Resposta incorreta
            if respostasUsuario[i] != vetorGabarito[i] {
                // Criar uma animacao que avise para o usuario que a resposta está incorreta
                animaAnswerWrong()
                limpaRespostas()
                return
            }
        }
        // resposta correta
        giveAnswer.removeAllActions()
        let rightAnswer = SKAction.playSoundFileNamed("right-answer.wav", waitForCompletion: true)
        giveAnswer.run(rightAnswer)
        let moveSnakeFirst = SKAction.moveTo(x: -(board.size.width/3 + 10), duration: 0.75)
        let moveSnakeLast = SKAction.moveTo(x: board.size.width/2 + 20, duration: 1.25)
        
        snake.run(moveSnakeFirst)
        
        // Usando a ação run para executar um bloco de código quando a animação da snake terminar
        let showNextPhaseAction = SKAction.run { [weak self] in
            self?.showNextPhaseSheet = true
        }
        let sequence = SKAction.sequence([moveSnakeLast, showNextPhaseAction])
    
        DispatchQueue.global().async {
            while self.apple.position != CGPoint(x: 0, y: 0) {
                 // print(self.apple.position)
            }
            print(self.apple.position)
            self.apple.removeAllActions()
            self.snake.run(sequence)
        }
        
        return
    }
    
    func animaAnswerWrong() {
        giveAnswer.removeAllActions()
        let errado = SKAction.setTexture(SKTexture(imageNamed: "wrong-block"))
        let direita = SKAction.moveTo(x: giveAnswer.position.x + 10, duration: 0.1)
        let esquerda = SKAction.moveTo(x: giveAnswer.position.x - 10, duration: 0.1)
        let volta = SKAction.moveTo(x: giveAnswer.position.x, duration: 0.1)
        let mudaTXT = SKAction.setTexture(SKTexture(imageNamed: "locked-answer"))
        let espera = SKAction.wait(forDuration: 0.3)
        let sequenciaAnswer = SKAction.sequence([errado, direita, esquerda, volta, espera, mudaTXT])
        giveAnswer.run(sequenciaAnswer)
    }
    
    func limpaRespostas() {
        for i in 0..<5 {
            retiraResposta(respostaRetirada: respostasUsuarioNodes[i])
            respostasUsuario[i] = ""
        }
        return
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        // Verificar se a colisão envolve a maçã
        if contact.bodyA.node?.name == "apple-game" || contact.bodyB.node?.name == "apple-game" {
            // Remover a maçã como node
            if let appleNode = contact.bodyA.node as? SKSpriteNode, appleNode.name == "apple-game" {
                let snakeNode = contact.bodyB.node as? SKSpriteNode ?? snake
                removeApple(nodeA: appleNode, nodeB: snakeNode)
            } else if let appleNode = contact.bodyB.node as? SKSpriteNode {
                let snakeNode = contact.bodyA.node as? SKSpriteNode ?? snake
                removeApple(nodeA: appleNode, nodeB: snakeNode)
            }
        }
    }
    
    func removeApple(nodeA: SKSpriteNode, nodeB: SKSpriteNode) {
        // Remover o physicsBody do nó
        nodeA.physicsBody = nil

        // abre a boca da cobra
        let abre = SKAction.setTexture(SKTexture(imageNamed: "open-mouth-snake"))
        let espera = SKAction.wait(forDuration: 0.5)
        let fecha = SKAction.setTexture(SKTexture(imageNamed: "snake"))
        let come = SKAction.playSoundFileNamed("eat-apple.wav", waitForCompletion: false)
        let abreFecha = SKAction.sequence([abre, come, espera, fecha])
        nodeB.run(abreFecha)

        // Remover o nó da cena com animação de desaparecimento
        let diminui = SKAction.scale(to: 0, duration: 0.3)
        let sequence = SKAction.sequence([diminui, SKAction.removeFromParent()])

        // Executar a animação em cascata
        nodeA.run(sequence)
    }
    
    func getTouchedNode(_ touches: Set<UITouch>)->SKNode? {
        guard let touch = touches.first else {return nil}
        let position = touch.location(in: self)
        guard let touchedNode = nodes(at: position).first else {return nil}
        return touchedNode
    }
    
    func retiraResposta(respostaRetirada: SKSpriteNode) {
        let aumenta = SKAction.scale(to: 1.25, duration: 0.1)
        let some = SKAction.scale(to: 0, duration: 0.3)
        let pop = SKAction.playSoundFileNamed("pop.wav", waitForCompletion: false)
        let sequencia = SKAction.sequence([aumenta, some, pop, SKAction.removeFromParent()])
        respostaRetirada.run(sequencia)
        return
    }
    
}
