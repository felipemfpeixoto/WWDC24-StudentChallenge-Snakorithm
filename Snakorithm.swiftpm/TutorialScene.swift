import Foundation
import SpriteKit

class TutorialScene: SKScene {
    
    lazy var pointer: SKSpriteNode = {
        let pointer = SKSpriteNode(imageNamed: "ponteiro-tutorial")
        pointer.position.x = self.frame.maxX - (pointer.size.width * 2)
        pointer.name = "pointer"
        pointer.zPosition = .infinity

        return pointer
    }()
    
    lazy var resp: SKSpriteNode = {
        let resp = SKSpriteNode(imageNamed: "up-arrow")
        resp.position.y = resp.size.height/2 + 10
        resp.name = "resp"

        return resp
    }()
    
    lazy var answerSquare: SKSpriteNode = {
        let answerSquare = SKSpriteNode(imageNamed: "answer-square")
        answerSquare.position.y = -(answerSquare.size.height/2 + 10)
        answerSquare.name = "answerSquare"

        return answerSquare
    }()
    
    lazy var texto1: SKLabelNode = {
        let label = SKLabelNode(fontNamed: "Itim-Regular")
        label.text = "To give an answer, click on"
        label.fontSize = 30
        label.position.y = resp.position.y + resp.size.height + 30
        return label
    }()
    
    lazy var texto2: SKLabelNode = {
        let label = SKLabelNode(fontNamed: "Itim-Regular")
        label.text = "the answer square at the top of the screen"
        label.fontSize = 30
        label.position.y = resp.position.y + resp.size.height
        return label
    }()
    
    lazy var texto4: SKLabelNode = {
        let label = SKLabelNode(fontNamed: "Itim-Regular")
        label.text = "To discard an answer, click on the answer"
        label.fontSize = 30
        label.position.y = answerSquare.position.y - answerSquare.size.height
        return label
    }()
    
    lazy var texto3: SKLabelNode = {
        let label = SKLabelNode(fontNamed: "Itim-Regular")
        label.text = "you gave before and it will pop out"
        label.fontSize = 30
        label.position.y = answerSquare.position.y - answerSquare.size.height - 30
        return label
    }()
    
    override func didMove(to view: SKView) {
        
        removeAllChildren()
        
        self.backgroundColor = UIColor(hex: "17A600")
        
        addChild(resp)
        
        addChild(answerSquare)
        
        addChild(pointer)
        
        addChild(texto1)
        
        addChild(texto2)
        
        addChild(texto3)
        
        addChild(texto4)
        
        animaTutorial()
    }
    
    func animaTutorial() {
        var newNode: SKSpriteNode!
        let vaiPraRespX = SKAction.moveTo(x: resp.position.x + pointer.size.width/2, duration: 1)
        let vaiPraRespY = SKAction.moveTo(y: resp.position.y - pointer.size.height/2, duration: 1)
        let vaiPraResp = SKAction.group([vaiPraRespX, vaiPraRespY])
        let trocaTextura = SKAction.setTexture(SKTexture(imageNamed: "click-tutorial"))
        let sleep = SKAction.wait(forDuration: 1)
        let trocaTextura2 = SKAction.setTexture(SKTexture(imageNamed: "ponteiro-tutorial"))
        let clicaResp = SKAction.run {
            newNode = self.copiaResp()
        }
        
        let vaiPraSquare = SKAction.moveTo(y: answerSquare.position.y - pointer.size.height/2, duration: 1)
        let retira = SKAction.run {
            self.retiraResposta(respostaRetirada: newNode)
        }
        
        let reinicia = SKAction.run {
            self.didMove(to: self.view!)
        }
        
        let sequencia = SKAction.sequence([vaiPraResp, trocaTextura, sleep, clicaResp, trocaTextura2, sleep, vaiPraSquare, trocaTextura, sleep, retira, trocaTextura2, sleep, reinicia])
        pointer.run(sequencia)
    }
    
    func copiaResp() -> SKSpriteNode {
        // cria uma copia do node clicado
        let newNode = resp.copy() as! SKSpriteNode
        newNode.position = resp.position
        addChild(newNode)
        
        let targetPosition = answerSquare.position // Altere para a posição desejada
        
        // Inicia a animação para mover o novo nó para uma posição específica
        let moveAction = SKAction.move(to: targetPosition, duration: 0.3)
        newNode.run(moveAction)
        
        newNode.run(SKAction.playSoundFileNamed("card-slide.wav", waitForCompletion: false))
        
        return newNode
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
