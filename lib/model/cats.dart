class Cat {
  String id;
  String created;
  String imageUrl;

  Cat();

  Cat.build(String imageUrl, String id, String created) {
    this.id = id;
    this.imageUrl = "https://cataas.com" + imageUrl;
    this.created = created;
  }
}

//{
// "id":"5b55c2abdf7368000f914b41",
// "created_at":"2018-07-23T11:57:30.298Z",
// "tags":[],
// "url":"/cat/5b55c2abdf7368000f914b41"}
