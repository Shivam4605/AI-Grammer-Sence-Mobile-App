class AiResponceModel {
  List<Candidates>? candidates;
  String? modelVersion;
  String? responseId;
  UsageMetadata? usageMetadata;

  AiResponceModel({
    this.candidates,
    this.modelVersion,
    this.responseId,
    this.usageMetadata,
  });

  factory AiResponceModel.fromJson(Map<String, dynamic> json) {
    return AiResponceModel(
      candidates: json['candidates'] != null
          ? (json['candidates'] as List)
                .map((element) => Candidates.fromJson(element))
                .toList()
          : [],
      modelVersion: json['modelVersion'] ?? "",
      responseId: json['responseId'] ?? "",
      usageMetadata: (json['usageMetadata'] != null)
          ? UsageMetadata.fromJson(json['usageMetadata'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "candidates": candidates?.map((element) => element.toJson()).toList(),
      "responseId": responseId,
      "modelVersion": modelVersion,
      "usageMetadata": usageMetadata?.toJson(),
    };
  }
}

class UsageMetadata {
  int? promptTokenCount;
  int? candidatesTokenCount;
  int? totalTokenCount;
  int? thoughtsTokenCount;
  String? serviceTier;
  List<PromptTokensDetails>? promptTokensDetails;

  UsageMetadata({
    this.candidatesTokenCount,
    this.promptTokenCount,
    this.promptTokensDetails,
    this.totalTokenCount,
    this.serviceTier,
    this.thoughtsTokenCount,
  });

  factory UsageMetadata.fromJson(Map<String, dynamic> json) {
    return UsageMetadata(
      candidatesTokenCount: json['candidatesTokenCount'] ?? 0,
      promptTokenCount: json['promptTokenCount'] ?? 0,
      totalTokenCount: json['totalTokenCount'] ?? 0,
      promptTokensDetails: json['promptTokensDetails'] != null
          ? (json['promptTokensDetails'] as List)
                .map((element) => PromptTokensDetails.fromJson(element))
                .toList()
          : [],
      thoughtsTokenCount: json['thoughtsTokenCount'] ?? 0,
      serviceTier: json['serviceTier'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "candidatesTokenCount": candidatesTokenCount,
      "promptTokenCount": promptTokenCount,
      "totalTokenCount": totalTokenCount,
      "promptTokensDetails": promptTokensDetails
          ?.map((element) => element.toJson())
          .toList(),
      "thoughtsTokenCount": thoughtsTokenCount,
      "serviceTier": serviceTier,
    };
  }
}

class PromptTokensDetails {
  String? modality;
  int? tokenCount;

  PromptTokensDetails({this.modality, this.tokenCount});

  factory PromptTokensDetails.fromJson(Map<String, dynamic> json) {
    return PromptTokensDetails(
      modality: json['modality'] ?? "",
      tokenCount: json['tokenCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {"modality": modality, "tokenCount": tokenCount};
  }
}

class Candidates {
  Content? content;
  String? finishReason;
  int? index;

  Candidates({
    required this.finishReason,
    required this.index,
    required this.content,
  });

  factory Candidates.fromJson(Map<String, dynamic> json) {
    return Candidates(
      finishReason: json['finishReason'] ?? "",
      index: json['index'] ?? 0,
      content: json['content'] != null
          ? Content.fromJson(json['content'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "finishReason": finishReason,
      "index": index,
      "content": content?.toJson(),
    };
  }
}

class Content {
  List<PartsContent>? partsList;
  String? role;

  Content({this.partsList, this.role});
  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      role: json['role'] ?? "",
      partsList: json['parts'] != null
          ? (json['parts'] as List)
                .map((element) => PartsContent.fromJson(element))
                .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "parts": partsList?.map((element) => element.toJson()).toList(),
      "role": role,
    };
  }
}

class PartsContent {
  String? text;
  String? thoughtSignature;

  PartsContent({this.text, this.thoughtSignature});

  factory PartsContent.fromJson(Map<String, dynamic> json) {
    return PartsContent(
      text: json['text'] ?? "",
      thoughtSignature: json['thoughtSignature'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {"text": text, "thoughtSignature": thoughtSignature};
  }
}
