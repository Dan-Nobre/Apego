//
//  OrganizarViewsModel.swift
//  Apego
//
//  Created by Daniel Nobre on 22/06/24.
//

let categorias = [
    "Camisa",
    "Calça",
    "Sapatos",
    "Acessórios"
]

struct Subtitles {
    static let iconesAdd = [
        "sun.max",
        "person.and.background.dotted",
        "square.dashed",
        "wand.and.stars.inverse"
    ]    
    static let bodyContent = [
        "Utilize um local com luz natural",
        "Fundo neutro te ajuda no enquadramento",
        "Centralizar a câmera na peça dá uma foto melhor",
        "Sombras e objetos do local podem atraplahar no recorte do fundo"
    ]
    
}


//ForEach(0..<Subtitles.iconesAdd.count) { index in
//                        HStack{
//                            VStack(alignment: .center){
//                                Image(systemName: "\(Subtitles.iconesAdd[index])")
//                            }
//                            VStack(alignment: .trailing){
//                                Text("\(Subtitles.bodyContent[index])")
//                            }
//                        }
//                        .padding(.bottom, 20)
//                    }

