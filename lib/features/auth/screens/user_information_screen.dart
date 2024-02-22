import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_whatsapp_clone_firebase_riverpod/common/utils/utils.dart';

class UserInformationScreen extends StatefulWidget {
  static const String routeName = '/user-information';
  const UserInformationScreen({super.key});

  @override
  State<UserInformationScreen> createState() => _UserInformationScreenState();
}

class _UserInformationScreenState extends State<UserInformationScreen> {
  final TextEditingController nameController = TextEditingController();
  File? image;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
  }

  void selectImage() async {
    image = await pickImageFromGallery(context);
    setState(() {
      
    });
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Stack(
                children: [
                 image == null ? CircleAvatar(
                    backgroundImage: NetworkImage('data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBwgHBgkIBwgKCgkLDRYPDQwMDRsUFRAWIB0iIiAdHx8kKDQsJCYxJx8fLT0tMTU3Ojo6Iys/RD84QzQ5OjcBCgoKDQwNGg8PGjclHyU3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3N//AABEIAJQAnQMBIgACEQEDEQH/xAAaAAEAAgMBAAAAAAAAAAAAAAAABAUBAgMH/8QAMBABAAIBAgQEBQIHAQAAAAAAAAECAwQREiExYQUiUXETM0FCUnKhIyQygZGx0RX/xAAUAQEAAAAAAAAAAAAAAAAAAAAA/8QAFBEBAAAAAAAAAAAAAAAAAAAAAP/aAAwDAQACEQMRAD8A9RAAAAAABpkyY8cfxLxX3BuIs6/DE8uKfaGP/Qw+l/8AAJYjV1uCetpj3rLvjvTJG9LRaO0g2AAAAAAAAAAAAaZMlcdZtedobqjU5pzZN/tjpAOmbW3vvGPy1/dFneZ3mZmfUADYANma2mluKk7SwAs667DwxvPP68pdsWbHljfHbdTOumyzhyxb7Z5THYFwEdgAAAAAAAAHLVW4dPkntsp1p4hP8rb3j/aqgGQAAAAAAAW+jtx6bHM9dtpdkTw2d9Pt6WlLAAAAAAAABG8R56W3vCqhcauk5NNese6oAAAAAAAABYeGfKv+pNRPDa7YJn8rTKWAAAAAAAADjqs3wMcWiOKZnbZU2nzTPrPRY+I1308TH22jdWgAAAAAAMxtvz327MALnBwThr8P+nbk6OOjjh01I7buwAAAAAAAANM1PiYb19Y5KXbaV6r9Xpa46Wy1mevT0BCAAAAAAZrHFeK+ssSm6LTVmK5ptO8TPIE+I4axEdI5MgAAAAAAAAA1yUjJjtS3SY2bAKS9Zpaa26xOzVM8Sptlrf8AKOaGAAAADNY4rRWOszsucVPhY60j6QrvDqRbUbz9tZlaAAAAAAAAAAAAAg+KT5ccd5QErxG8WzRWPtj90UAAAAEzwv5uT9MLFVaHLFM+08otG2/91qAAAAAAAAAOObUYsPK1t7fjHOUHNrMuTeK+SvYE7NqMWHle3m9I6oWbXXtyxxwR6/VF25gHXnPUAAAAADZIw6zJi8s+evpKOAtMetw36zNZ7pETExvExMdlFs3x3vjnelprPYF2K/D4havzq7x616puPJTJXelot7A3AAlD1+a+OIpSduLrP1AFd3AAAAAAAAAAAAAAZra1LcVLTE+sMALXR5rZsW99t4+rv/wAf//Z'),
                    radius: 64,
                  ) : CircleAvatar(
                    backgroundImage: FileImage(image!),
                    radius: 64,
                  ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(Icons.add_a_photo)
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    width: size.width * 0.85,
                    padding: const EdgeInsets.all(20),
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        hintText: 'Enter your name'
                      )
                    )
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.done),)
                ],
              )
            ],
          )
        ),
      )
    );
  }
}