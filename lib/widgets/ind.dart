import 'package:flutter/material.dart';

class IndicadorProgressoAnimado extends StatefulWidget {
  final double value;

  IndicadorProgressoAnimado({
    @required this.value,
  });

  @override
  State<StatefulWidget> createState() {
    return _IndicadorProgressoAnimadoState();
  }
}

class _IndicadorProgressoAnimadoState extends State<IndicadorProgressoAnimado> with SingleTickerProviderStateMixin {
  AnimationController _controle;
  Animation<Color> _animacaoCor;
  Animation<double> _curvaAnimacao;

  void initState() {
    super.initState();
    _controle = AnimationController(duration: Duration(milliseconds: 1200), vsync: this);

    var trocaCor = TweenSequence([
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.red, end: Colors.orange),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.orange, end: Colors.yellow),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.yellow, end: Colors.green),
        weight: 1,
      ),
    ]);

    _animacaoCor = _controle.drive(trocaCor);
    _curvaAnimacao = _controle.drive(CurveTween(curve: Curves.easeIn));
  }

  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controle.animateTo(widget.value);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controle,
      builder: (context, child) => LinearProgressIndicator(
        value: _curvaAnimacao.value,
        valueColor: _animacaoCor,
        backgroundColor: _animacaoCor.value.withOpacity(0.4),
      ),
    );
  }
}