import Foundation
import SpriteKit

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

var posicoes: [CGPoint] = []

class GameSceneLevel1: SKScene, SKPhysicsContactDelegate {
    
    var showNextPhaseSheet = false {
        didSet { didFinishGame(showNextPhaseSheet)
            
        }
    }
    var didFinishGame:(Bool)->Void = {_ in}
    
    lazy var resp1: SKSpriteNode = {
        let resp1 = SKSpriteNode(imageNamed: "left-arrow")
        resp1.position.y = self.frame.maxY - resp1.size.height
        resp1.position.x = -(resp1.size.width + resp1.size.width/2)
        resp1.name = "resp1"

        return resp1
    }()
    
    lazy var resp2: SKSpriteNode = {
        let resp2 = SKSpriteNode(imageNamed: "up-arrow-button")
        resp2.position.y = self.frame.maxY - resp2.size.height
        resp2.position.x = -(resp2.size.width/2)
        resp2.name = "resp2"

        return resp2
    }()
    
    lazy var resp3: SKSpriteNode = {
        let resp3 = SKSpriteNode(imageNamed: "down-arrow")
        resp3.position.y = self.frame.maxY - resp3.size.height
        resp3.position.x = (resp3.size.width/2)
        resp3.name = "resp3"

        return resp3
    }()
    
    lazy var resp4: SKSpriteNode = {
        let resp4 = SKSpriteNode(imageNamed: "right-arrow")
        resp4.position.y = self.frame.maxY - resp4.size.height
        resp4.position.x = (resp4.size.width + resp4.size.width/2)
        resp4.name = "resp4"

        return resp4
    }()
    
    lazy var answerSquare1: SKSpriteNode = {
        let answerSquare1 = SKSpriteNode(imageNamed: "answer-square")
        answerSquare1.position.y = self.frame.maxY - (answerSquare1.size.height * 2) - 10
        answerSquare1.position.x = -(answerSquare1.size.width + 10)
        answerSquare1.name = "answerSquare1"

        return answerSquare1
    }()
    
    lazy var answerSquare2: SKSpriteNode = {
        let answerSquare2 = SKSpriteNode(imageNamed: "answer-square")
        answerSquare2.position.y = self.frame.maxY - (answerSquare2.size.height * 2) - 10
        answerSquare2.name = "answerSquare2"

        return answerSquare2
    }()
    
    lazy var answerSquare3: SKSpriteNode = {
        let answerSquare3 = SKSpriteNode(imageNamed: "answer-square")
        answerSquare3.position.y = self.frame.maxY - (answerSquare3.size.height * 2) - 10
        answerSquare3.position.x = answerSquare3.size.width + 10
        answerSquare3.name = "answerSquare3"

        return answerSquare3
    }()
    
    lazy var giveAnswer: SKSpriteNode = {
        let giveAnswer = SKSpriteNode(imageNamed: "locked-answer")
        giveAnswer.position.y = self.frame.maxY - (giveAnswer.size.height * 2) - 10
        giveAnswer.position.x = (giveAnswer.size.width + 20) * 2
        giveAnswer.name = "giveAnswer"

        return giveAnswer
    }()
    
    lazy var board: SKSpriteNode = {
        let board = SKSpriteNode(imageNamed: "tabuleiro")
        board.name = "board"
        board.position.y = ((answerSquare1.position.y - answerSquare1.size.height/2) + self.frame.minY) / 2

        return board
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
        fences.name = "fences"

        return fences
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
    
    var apple: SKSpriteNode {
        let apple = SKSpriteNode(imageNamed: "apple-game")
        
        apple.physicsBody = SKPhysicsBody(texture: apple.texture!, size: apple.size)
        apple.physicsBody?.affectedByGravity = false
        apple.physicsBody?.isDynamic = true
        apple.physicsBody?.allowsRotation = false

        
        apple.physicsBody?.categoryBitMask =  1
        
        apple.name = "apple-game"

        return apple
    }

    var respostasUsuario: [String] = ["", "", ""]
    
    var respostasUsuarioNodes: [SKSpriteNode] = []
    
    var vetorResps = ["resp1", "resp2", "resp3", "resp4"]
    
    var vetorGabarito = ["resp4", "resp4", "resp4"]
    
    var todasResps: Bool = false
    
    var respEnviada: Bool = false
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity.dy = -1
        
        board.removeAllChildren()
        removeAllChildren()
        respostasUsuario = ["", "", ""]
        
        self.backgroundColor = UIColor(hex: "0F6B00")
        
        addChild(resp1)
        
        addChild(resp2)
        
        addChild(resp3)
        
        addChild(resp4)
        
        respostasUsuarioNodes = [resp1, resp2, resp3]
        
        addChild(answerSquare1)
        
        addChild(answerSquare2)
        
        addChild(answerSquare3)
        
        addChild(giveAnswer)
        giveAnswer.removeAllActions()
        giveAnswer.texture = SKTexture(imageNamed: "locked-answer")
        
        posicoes.append(answerSquare1.position)
        
        posicoes.append(answerSquare2.position)
        
        posicoes.append(answerSquare3.position)
        
        addChild(board)
        
        board.addChild(snake)
        
        board.addChild(apple)
        
        board.addChild(fences)
        
        board.addChild(exit)
        
        todasResps = false
        
        respEnviada = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touchedNode = getTouchedNode(touches) {
            if touchedNode.position.y >= (self.frame.maxY - resp1.size.height) {
                for i in 0..<3 {
                    if respostasUsuario[i] == "" {
                        respEnviada = false
                        let newNode = touchedNode.copy() as! SKSpriteNode
                        newNode.position = touchedNode.position
                        newNode.name = touchedNode.name
                        addChild(newNode)
                        respostasUsuarioNodes[i] = newNode
                        
                        respostasUsuario[i] = touchedNode.name!
                        
                        let targetPosition = posicoes[i]
                        
                        let moveAction = SKAction.move(to: targetPosition, duration: 0.3)
                        newNode.run(moveAction)
                        
                        newNode.run(SKAction.playSoundFileNamed("card-slide.wav", waitForCompletion: false))
                        
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
                
                if vetorResps.contains(nodeName) && touchedNode.position.y == answerSquare1.position.y {
                    for i in 0..<3 {
                        if posicoes[i] == touchedNode.position {
                            respostasUsuario[i] = ""
                            respostasUsuarioNodes[i] = resp1
                        }
                    }
                    retiraResposta(respostaRetirada: touchedNode as! SKSpriteNode)
                    giveAnswer.removeAllActions()
                    giveAnswer.texture = SKTexture(imageNamed: "locked-answer")
                    todasResps = false
                }
                else if touchedNode.name == "giveAnswer" && todasResps && !respEnviada {
                    respEnviada = true
                    comparaGabarito()
                }
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "apple-game" || contact.bodyB.node?.name == "apple-game" {
            
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
        nodeA.physicsBody = nil

        let abre = SKAction.setTexture(SKTexture(imageNamed: "open-mouth-snake"))
        let espera = SKAction.wait(forDuration: 0.5)
        let fecha = SKAction.setTexture(SKTexture(imageNamed: "snake"))
        let come = SKAction.playSoundFileNamed("eat-apple.wav", waitForCompletion: false)
        let abreFecha = SKAction.sequence([abre, come, espera, fecha])
        nodeB.run(abreFecha)

        let diminui = SKAction.scale(to: 0, duration: 0.3)
        let sequence = SKAction.sequence([diminui, SKAction.removeFromParent()])

        nodeA.run(sequence)
    }
    
    func getTouchedNode(_ touches: Set<UITouch>)->SKNode? {
        guard let touch = touches.first else {return nil}
        let position = touch.location(in: self)
        guard let touchedNode = nodes(at: position).first else {return nil}
        return touchedNode
    }
    
    func comparaGabarito() {
        for i in 0..<3 {
            if respostasUsuario[i] != vetorGabarito[i] {
                animaAnswerWrong()
                limpaRespostas()
                return
            }
        }
        giveAnswer.removeAllActions()
        let rightAnswer = SKAction.playSoundFileNamed("right-answer.wav", waitForCompletion: true)
        giveAnswer.run(rightAnswer)
        let moveSnake = SKAction.moveTo(x: board.size.width/2 + 20, duration: 2)
        
        let showNextPhaseAction = SKAction.run { [weak self] in
            self?.showNextPhaseSheet = true
        }
        
        let sequence = SKAction.sequence([moveSnake, showNextPhaseAction])
        snake.run(sequence)
        
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
}


extension SKNode {
    func addChildIfYouCan(_ node: SKNode) {
        guard node.parent == nil else { return }
        self.addChild(node)
    }
}
