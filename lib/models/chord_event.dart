/// Evento de troca de acorde em um instante específico.
class ChordEvent {
  final Duration timestamp;
  final String chord;

  const ChordEvent({
    required this.timestamp,
    required this.chord,
  });
}
