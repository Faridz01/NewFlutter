class HeadlineResponse {
  // Deklarasi variabel bool dengan nullable (?)
  bool? succsess;
   // Deklarasi variabel String dengan nullable (?)
  String? message;
  // Deklarasi variabel List yang berisi objek dari kelas Data dengan nullable (?)
  List<Data>? data;


// Konstruktor dengan parameter opsional
  HeadlineResponse({this.succsess, this.message, this.data});

  HeadlineResponse.fromJson(Map<String, dynamic> json) {
    succsess = json['succsess'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {

    // Konstruktor untuk mengambil data dari JSON
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['succsess'] = this.succsess;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {

  // Deklarasi variabel String dengan nullable (?)
  String? name;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;

  Data(
      {this.name,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content});

  Data.fromJson(Map<String, dynamic> json) {
    // Konstruktor untuk mengambil data dari JSON
    name = json['name'];
    author = json['author'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    urlToImage = json['urlToImage'];
    publishedAt = json['publishedAt'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
     // Metode untuk mengonversi objek menjadi JSON
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['author'] = this.author;
    data['title'] = this.title;
    data['description'] = this.description;
    data['url'] = this.url;
    data['urlToImage'] = this.urlToImage;
    data['publishedAt'] = this.publishedAt;
    data['content'] = this.content;
    return data;
  }
}