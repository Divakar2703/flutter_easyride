
import 'dart:convert';

Notes notesFromJson(String str) => Notes.fromJson(json.decode(str));

String notesToJson(Notes data) => json.encode(data.toJson());

class Notes {
    DeliveryNotes deliveryNotes;
    String status;
    String message;
    int statusCode;

    Notes({
        required this.deliveryNotes,
        required this.status,
        required this.message,
        required this.statusCode,
    });

    factory Notes.fromJson(Map<String, dynamic> json) => Notes(
        deliveryNotes: DeliveryNotes.fromJson(json["delivery_notes"]),
        status: json["status"],
        message: json["message"],
        statusCode: json["statusCode"],
    );

    Map<String, dynamic> toJson() => {
        "delivery_notes": deliveryNotes.toJson(),
        "status": status,
        "message": message,
        "statusCode": statusCode,
    };
}

class DeliveryNotes {
    List<String> notes;
    List<String> additionalInstructions;

    DeliveryNotes({
        required this.notes,
        required this.additionalInstructions,
    });
    factory DeliveryNotes.fromJson(Map<String, dynamic> json) => DeliveryNotes(
        notes: List<String>.from(json["notes"].map((x) => x)),
        additionalInstructions: List<String>.from(json["additional_instructions"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "notes": List<dynamic>.from(notes.map((x) => x)),
        "additional_instructions": List<dynamic>.from(additionalInstructions.map((x) => x)),
    };
}
