import Foundation
import SpriteKit

var posicoesLevel3: [CGPoint] = []

class GameSceneLevel3: SKScene, SKPhysicsContactDelegate {
    
    var showNextPhaseSheet = false {
        didSet { didFinishGame(showNextPhaseSheet)
        }
    }
    var didFinishGame:(Bool)->Void = {_ in}
    
    lazy var resp1: SKSpriteNode = {
        let resp1 = SKSpriteNode(imageNamed: "left-arrow")
        resp1.position.y = self.frame.maxY - resp1.size.height/2
        resp1.position.x = -(resp1.size.width + resp1.size.width/2)
        resp1.name = "resp1"

        return resp1
    }()
    
    lazy var resp2: SKSpriteNode = {
        let resp2 = SKSpriteNode(imageNamed: "up-arrow-button")
        resp2.position.y = self.frame.maxY - resp2.size.height/2
        resp2.position.x = -(resp2.size.width/2)
        resp2.name = "resp2"

        return resp2
    }()
    
    lazy var resp3: SKSpriteNode = {
        let resp3 = SKSpriteNode(imageNamed: "down-arrow")
        resp3.position.y = self.frame.maxY - resp3.size.height/2
        resp3.position.x = (resp3.size.width/2)
        resp3.name = "resp3"

        return resp3
    }()
    
    lazy var resp4: SKSpriteNode = {
        let resp4 = SKSpriteNode(imageNamed: "right-arrow")
        resp4.position.y = self.frame.maxY - resp4.size.height/2
        resp4.position.x = (resp4.size.width + resp4.size.width/2)
        resp4.name = "resp4"

        return resp4
    }()
    
    lazy var loopBlock: SKSpriteNode = {
        let loopBlock = SKSpriteNode(imageNamed: "loop-block-game")
        loopBlock.position.y = self.frame.maxY - loopBlock.size.height
        loopBlock.name = "loopBlock"
        return loopBlock
    }()
    
    lazy var loopSymbol: SKSpriteNode = {
        let loopSymbol = SKSpriteNode(imageNamed: "loop-symbol")
        loopSymbol.position.y = loopBlock.size.height/2 - loopSymbol.size.height/2 - 10
        loopSymbol.position.x = -loopBlock.size.width/2 + loopSymbol.size.width/2 + 10
        loopSymbol.name = "loopSymbol"
        
        return loopSymbol
    }()
    
    lazy var ifBlock: SKSpriteNode = {
        let ifBlock = SKSpriteNode(imageNamed: "if-block-game")
        ifBlock.position.y = self.frame.maxY - (ifBlock.size.height * 1.5 + 25)
        ifBlock.position.x = -(ifBlock.size.width * 1.5 + 15)
        ifBlock.name = "ifSquare"

        return ifBlock
    }()
    
    lazy var appleIn: SKSpriteNode = {
        let appleIn = SKSpriteNode(imageNamed: "apple-in-square-game")
        appleIn.position.y = self.frame.maxY - (appleIn.size.height * 1.5) - 25
        appleIn.position.x = -(appleIn.size.width/2 + 5)
        appleIn.name = "appleIn"

        return appleIn
    }()
    
    lazy var doSquare: SKSpriteNode = {
        let doSquare = SKSpriteNode(imageNamed: "do-block-game")
        doSquare.position.y = self.frame.maxY - (doSquare.size.height * 1.5) - 25
        doSquare.position.x = (doSquare.size.width/2 + 5)
        doSquare.name = "doSquare"

        return doSquare
    }()
    
    lazy var answerSquare1: SKSpriteNode = {
        let answerSquare2_2 = SKSpriteNode(imageNamed: "answer-square_2")
        answerSquare2_2.position.y = self.frame.maxY - (doSquare.size.height * 1.5) - 25
        answerSquare2_2.position.x = (answerSquare2_2.size.width * 1.5 + 15)
        answerSquare2_2.name = "answerSquare1"

        return answerSquare2_2
    }()
    
    lazy var answerSquare2: SKSpriteNode = {
        let answerSquare2 = SKSpriteNode(imageNamed: "answer-square_2")
        answerSquare2.position.y = self.frame.maxY - (doSquare.size.height * 1.5) - 25
        answerSquare2.position.x = (answerSquare2.size.width * 2.5 + 25)
        answerSquare2.name = "answerSquare2"

        return answerSquare2
    }()
    
    lazy var elseSquare: SKSpriteNode = {
        let elseSquare = SKSpriteNode(imageNamed: "else-block-game")
        elseSquare.position.y = self.frame.maxY - (elseSquare.size.height * 2.5) - 35
        elseSquare.position.x = -(appleIn.size.width/2 + 5)
        elseSquare.name = "elseSquare"

        return elseSquare
    }()
    
    lazy var answerSquare3: SKSpriteNode = {
        let answerSquare2 = SKSpriteNode(imageNamed: "answer-square_2")
        answerSquare2.position.y = self.frame.maxY - (elseSquare.size.height * 2.5) - 35
        answerSquare2.position.x = (doSquare.size.width + 30)
        answerSquare2.name = "answerSquare3"

        return answerSquare2
    }()
    
    lazy var board: SKSpriteNode = {
        let board = SKSpriteNode(imageNamed: "tabuleiro-loop")
        board.name = "board"
        board.position.y = ((loopBlock.position.y - loopBlock.size.height/2) + self.frame.minY) / 2

        return board
    }()
    
    lazy var fencesRight: SKNode = {
        let fences = SKNode()
        
        let fence1 = SKSpriteNode(imageNamed: "fence-loop-right")
        fence1.name = "fence1"
        fence1.position.y = board.size.height/3
        
        let fence2 = SKSpriteNode(imageNamed: "fence-loop-right")
        fence2.name = "fence2"
        
        let fence3 = SKSpriteNode(imageNamed: "fence-loop-right")
        fence3.name = "fence3"
        fence3.position.y = -board.size.height/3
        
        fences.addChild(fence1)
        fences.addChild(fence2)
        fences.addChild(fence3)
        
        fences.position.x = board.size.width/2 + 30

        return fences
    }()
    
    lazy var fencesUp: SKNode = {
        let fences = SKNode()
        
        let fence1 = SKSpriteNode(imageNamed: "fence-loop-up")
        fence1.name = "fence4"
        fence1.position.x = -board.size.width/3
        
        let fence2 = SKSpriteNode(imageNamed: "fence-loop-up")
        fence2.name = "fence5"
        
        fences.addChild(fence1)
        fences.addChild(fence2)
        
        fences.position.y = board.size.height/2 + 30

        return fences
    }()
    
    lazy var snake: SKSpriteNode = {
        let snake = SKSpriteNode(imageNamed: "close-mouth-snake-loop")
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
        let exit = SKSpriteNode(imageNamed: "placa-exit-reta")
        exit.name = "exit"
        exit.position.x = ((board.size.width/2) - exit.size.width/2) + 10
        exit.position.y = board.size.height/2 + exit.size.height/2
        exit.zPosition = -1

        return exit
    }()
    
    var apple: SKSpriteNode {
        let apple = SKSpriteNode(imageNamed: "apple-loop")
        
        apple.position.x = board.size.width/3
        
        apple.physicsBody = SKPhysicsBody(texture: apple.texture!, size: apple.size)
        apple.physicsBody?.affectedByGravity = false
        apple.physicsBody?.isDynamic = true
        apple.physicsBody?.allowsRotation = false

        apple.physicsBody?.categoryBitMask =  1
        
        apple.name = "apple-game"

        return apple
    }
    
    lazy var giveAnswer: SKSpriteNode = {
        let giveAnswer = SKSpriteNode(imageNamed: "locked-answer")
        giveAnswer.position.y = self.frame.maxY - loopBlock.size.height
        giveAnswer.position.x = loopBlock.size.width/2 + giveAnswer.size.width - 30
        giveAnswer.name = "giveAnswer"

        return giveAnswer
    }()
    
    var respostasUsuario: [String] = ["", "", ""]
    
    var respostasUsuarioNodes: [SKSpriteNode] = []
    
    var vetorResps = ["resp1", "resp2", "resp3", "resp4"]
    
    var vetorGabarito = ["resp4", "resp2", "resp4"]
    
    var todasResps: Bool = false
    
    var respEnviada: Bool = true
    
    override func didMove(to view: SKView) {
        
        loopBlock.removeAllChildren()
        board.removeAllChildren()
        removeAllChildren()
        
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity.dy = -1
        
        self.backgroundColor = UIColor(hex: "0F6B00")
        
        respostasUsuario = ["", "", ""]

        addChild(resp1)
        
        addChild(resp2)
        
        addChild(resp3)
        
        addChild(resp4)
        
        respostasUsuarioNodes = [resp1, resp2, resp3]
        
        addChild(loopBlock)
        
        loopBlock.addChild(loopSymbol)
        
        addChild(ifBlock)
        
        addChild(appleIn)
        
        addChild(doSquare)
        
        addChild(answerSquare1)
        
        addChild(elseSquare)
        
        addChild(answerSquare2)
        
        addChild(answerSquare3)
        
        addChild(giveAnswer)
        
        addChild(board)
        
        board.addChild(fencesRight)
        
        board.addChild(fencesUp)
        
        board.addChild(snake)
        
        board.addChild(apple)
        
        board.addChild(exit)
        
        posicoesLevel3.append(answerSquare1.position)
        
        posicoesLevel3.append(answerSquare2.position)
        
        posicoesLevel3.append(answerSquare3.position)
        
        todasResps = false
        
        respEnviada = false
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touchedNode = getTouchedNode(touches) {
            
            // Se o nó clicado esta nas opcoes de resposta
            if touchedNode.position.y >= (self.frame.maxY - resp1.size.height) {
                // add o nome ao array, para dps comparar a resposta dada com o gabarito
                for i in 0..<3 {
                    // Pega a primeira posicao com uma string vazia
                    if respostasUsuario[i] == "" {
                        respEnviada = false
                        // cria uma copia do node clicado
                        let newNode = touchedNode.copy() as! SKSpriteNode
                        newNode.position = touchedNode.position
                        newNode.name = touchedNode.name
                        addChild(newNode)
                        respostasUsuarioNodes[i] = newNode
                        
                        respostasUsuario[i] = touchedNode.name!
                        
                        let targetPosition = posicoesLevel3[i] // Altere para a posição desejada
                        
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
                if vetorResps.contains(nodeName) && touchedNode.position.y <= answerSquare1.position.y {
                    // remove a resposta da lista, substituindo por uma string vazia
                    for i in 0..<3 {
                        if posicoesLevel3[i] == touchedNode.position {
                            respostasUsuario[i] = ""
                            respostasUsuarioNodes[i] = resp1
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
    
    func comparaGabarito() {
        for i in 0..<3 {
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
        
        
        let vaiAteMaca = SKAction.moveTo(x: apple.position.x - snake.size.width/4 + 20, duration: 1)
        
        // Adicione um pequeno atraso antes de começar a rotação
        let mudaCurva1 = SKAction.setTexture(SKTexture(imageNamed: "frame-1-transparent"))
        let mudaCurva2 = SKAction.setTexture(SKTexture(imageNamed: "frame-2-transparent"))
        let mudaCurva3 = SKAction.setTexture(SKTexture(imageNamed: "frame-3-transparent"))
        let mudaCurva4 = SKAction.setTexture(SKTexture(imageNamed: "frame-4-transparent"))
        let mudaCurva5 = SKAction.setTexture(SKTexture(imageNamed: "frame-5-transparent"))
        let mudaCurva6 = SKAction.setTexture(SKTexture(imageNamed: "frame-6-transparent"))
    
        let sobeTeste = SKAction.moveBy(x: 0, y: 5, duration: 0.05)
        
        let sobeEmuda1 = SKAction.group([mudaCurva1, sobeTeste])
        let sobeEmuda2 = SKAction.group([mudaCurva2, sobeTeste])
        let sobeEmuda3 = SKAction.group([mudaCurva3, sobeTeste])
        let sobeEmuda4 = SKAction.group([mudaCurva4, sobeTeste])
        let sobeEmuda5 = SKAction.group([mudaCurva5, sobeTeste])
        let sobeEmuda6 = SKAction.group([mudaCurva6, sobeTeste])
        
        let sobe = SKAction.moveTo(y: board.size.height/2, duration: 0.7)
        
        let permanent = SKAction.run {
            self.snake.texture = SKTexture(imageNamed: "frame-6-transparent")
        }
        
        let sequence = SKAction.sequence([vaiAteMaca, sobeEmuda1, sobeEmuda2, sobeEmuda3, sobeEmuda4, sobeEmuda5, sobeEmuda6, permanent])
        
        let showNextPhaseAction = SKAction.run { [weak self] in
            self?.showNextPhaseSheet = true
        }
        
        // Execução da sequência na cobra
        snake.run(sequence, completion: {
            // Definir a textura da cobra como "frame-6-transparent" ao final da animação
            let sequenceEnd = SKAction.sequence([sobe, showNextPhaseAction])
            self.snake.run(sequenceEnd)
        })
        
        
        return
    }

    
    func removeApple(nodeA: SKSpriteNode, nodeB: SKSpriteNode) {
        // Remover o physicsBody do nó
        nodeA.physicsBody = nil

        // abre a boca da cobra
        let abre = SKAction.setTexture(SKTexture(imageNamed: "open-mouth-snake"))
        let espera = SKAction.wait(forDuration: 0.5)
        let come = SKAction.playSoundFileNamed("eat-apple.wav", waitForCompletion: false)
        let abreFecha = SKAction.sequence([abre, come, espera])
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
    
    func limpaRespostas() {
        for i in 0..<3 {
            retiraResposta(respostaRetirada: respostasUsuarioNodes[i])
            respostasUsuario[i] = ""
        }
        return
    }
    
    func retiraResposta(respostaRetirada: SKSpriteNode) {
        let aumenta = SKAction.scale(to: 1.25, duration: 0.1)
        let some = SKAction.scale(to: 0, duration: 0.3)
        let pop = SKAction.playSoundFileNamed("pop.wav", waitForCompletion: false)
        let sequencia = SKAction.sequence([aumenta, some, pop, SKAction.removeFromParent()])
        respostaRetirada.run(sequencia)
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
}
