
class Onboard {
  final String image, title, description;

  Onboard({
    required this.image,
    required this.title,
    required this.description,
  });
}


final List<Onboard> onboardData = [
  Onboard(
      image: "assets/illustration/onboard-1.png",
      title: "Bitki Tanıma ve Bakım Uygulaması",
      description: "Bitki severler için tasarlanmış, doğada veya çevrenizde gördüğünüz bitkileri tanımanızı sağlayan ve doğru bakım bilgilerini sunan PlantIdentifyCare uygulamasına hoş geldiniz!"),
  Onboard(
      image: "assets/illustration/onboard-2.png",
      title: "Kişisel Bitki Koleksiyonunuzu Yönetin",
      description: "PlantIdentifyCare ile kendi bitki koleksiyonunuzu oluşturun, bitkilerinizi düzenleyin ve sevdiklerinizle paylaşın. Bitki yetiştiriciliğine meraklı olanlar için kişisel bitki koleksiyonlarınızı yönetmek hiç bu kadar kolay olmamıştı!"),
  Onboard(
      image: "assets/illustration/onboard-3.jpg",
      title: "Bitki Bakım Rehberi",
      description: "PlantIdentifyCare, bitki bakımı hakkında size ayrıntılı bilgi sağlar. Bitkilerinizin nasıl sulanacağını, gübrelenmesi gerektiğini ve diğer önemli bakım adımlarını öğrenmek için bu uygulamayı kullanabilirsiniz. Bitkilerinizi daha sağlıklı ve güçlü tutmanın anahtarı burada!"),
  Onboard(
      image: "assets/illustration/onboard-4.jpg",
      title: "Bitki Doktorunuz Her An Yanınızda",
      description: "PlantIdentifyCare'in yenilikçi yapay zeka özelliği olan 'Bitki Doktorum' ile bitki bakımıyla ilgili sorularınıza yanıtlar bulun. Uygulamamızın yapay zeka chatbot'u size en doğru tavsiyeleri sunarak bitkilerinizin sağlığı için destek olacak."),
];
