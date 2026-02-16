import 'dart:math';

asyncStudy () {
  // execucaoNormal();
  // assincronismoBasico();
  // usandoFuncoesAssincronas();
  esperandoFuncoesAssincronas();
}

void execucaoNormal(){
  print("\nExecucao Normal");
  print("01");
  print("02");
  print("03");
  print("04");
  print("05");
}

void assincronismoBasico(){
  print("\nAssincronismo Basico");
  print("01");
  print("02");
  Future.delayed(Duration(seconds: 2), () {
    print("03");
  });
  print("04");
  print("05");
}

void usandoFuncoesAssincronas() {
  print("\nUsando funcoes assincronas");
  print("A");
  print("B");
  getRandomInt(3).then((value) => print("O numero aleatorio e $value"));
  print("C");
  print("D");
}

void esperandoFuncoesAssincronas() async {
  print("\nUsando funcoes assincronas");
  print("A");
  print("B");
  await getRandomInt(4).then((value) => print("O numero aleatorio e $value"));
  print("C");
  print("D");
}

Future<int> getRandomInt(int time) async {
  await Future.delayed(Duration(seconds: time));

  Random rng = Random();

  return rng.nextInt(10);
}
