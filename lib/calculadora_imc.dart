import 'package:flutter/material.dart';

class CalculadoradeIMC extends StatefulWidget {
  const CalculadoradeIMC({super.key});

  @override
  State<CalculadoradeIMC> createState() => _CalculadoradeIMCState();
}

class _CalculadoradeIMCState extends State<CalculadoradeIMC> {
  TextEditingController pesoController = TextEditingController(text: '');
  TextEditingController alturaController = TextEditingController(text: '');
  double imc = 0.0;
  String classificacao = '';
  Color corResultado = Colors.green;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            imc == 0.0
                ? Text(
                    "Adicione valores de peso e altura",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.red,
                      fontStyle: FontStyle.italic,
                    ),
                  )
                : Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(150),
                      border: Border.all(color: corResultado, width: 10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          imc.toStringAsFixed(2),
                          style: TextStyle(fontSize: 37, color: corResultado),
                        ),
                        SizedBox(height: 10),
                        Text(
                          classificacao,
                          style: TextStyle(fontSize: 24, color: corResultado),
                        ),
                      ],
                    ),
                  ),
            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text('Seu Peso'),
                    SizedBox(height: 6),
                    SizedBox(
                      width: 75,
                      child: TextField(
                        controller: pesoController,
                        keyboardType: TextInputType.number,
                        onSubmitted: (_) => FocusScope.of(context).unfocus(),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          suffixText: 'kg',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 22),
                Column(
                  children: [
                    Text('Sua Altura'),
                    SizedBox(height: 6),
                    SizedBox(
                      width: 75,
                      child: TextField(
                        controller: alturaController,
                        keyboardType: TextInputType.number,
                        onSubmitted: (_) => FocusScope.of(context).unfocus(),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          suffixText: 'm',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox.fromSize(size: Size(0, 20)),
            SizedBox(
              width: 220,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  double? peso = double.tryParse(pesoController.text.trim());
                  double? altura = double.tryParse(alturaController.text.trim());
                  setState(() {
                    if (peso == null || altura == null || peso <= 0 || altura <= 0) {
                      imc = 0.0;
                      classificacao = 'Valores inválidos';
                      corResultado = Colors.red;
                    } else {
                      imc = peso / (altura * altura);
                      classificacao = getClassificacao(imc);
                      corResultado = getCorIMC(imc);
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Calcular',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    
    }
  String getClassificacao(double imc){
      if (imc <= 18.5){
        return 'Abaixo do Peso';
      } else if (imc <= 24.9){
        return 'Peso Normal';
      } else if (imc <= 29.9){
        return 'Sobrepeso';
      } else if (imc <= 34.9){
        return 'Obesidade Grau I';
      } else if (imc <= 39.9){
        return 'Obesidade Grau II';
      } else{
        return 'Obesidade Grau III';
      }
  }
  Color getCorIMC(double imc){
      if (imc <= 18.5){
        return Colors.blue;
      } else if (imc <= 24.9){
        return Colors.green;
      } else if (imc <= 29.9){
        return Colors.yellow;
      } else if (imc <= 34.9){
        return Colors.orange;
      } else if (imc <= 39.9){
        return Colors.red;
      } else{
        return Colors.purple;
      }
  }
}
