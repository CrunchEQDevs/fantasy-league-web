import 'package:flutter/material.dart';
import 'buttom_home.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color.fromARGB(255, 3, 24, 55),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 31, 31, 32),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                  'assets/logo.png',
                  height: 90,
            
          ),
                  Text(
                    'Fantasy League',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.sports_soccer, color: Colors.white,),
              title: Text(
                'Premier League',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              onTap: () {
                // Navegar para a tela da Premier League
                Navigator.pushNamed(context, '/premier-league');
              },
            ),
            ListTile(
              leading: Icon(Icons.sports_soccer, color: Colors.white,),
              title: Text(
                'La Liga',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              onTap: () {
                // Navegar para a tela da La Liga
                Navigator.pushNamed(context, '/la-liga');
              },
            ),
            ListTile(
              leading: Icon(Icons.sports_soccer, color: Colors.white,),
              title: Text(
                'Brasileirão',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              onTap: () {
                // Navegar para a tela do Brasileirão
                Navigator.pushNamed(context, '/brasileirao');
              },
            ),
            
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              
              child: BottomHome(
                text: 'Monte sua Liga',
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                },
                backgroundColor: const Color(0xFFED4F00),
                textColor:Colors.white,
              ),
            ),
            // Adicione aqui seus itens de menu quando precisar
            // Exemplo:
            // ListTile(
            //   leading: Icon(Icons.home, color: Colors.white),
            //   title: Text('Home', style: TextStyle(color: Colors.white)),
            //   onTap: () {},
            // ),
          ],
        ),
      ),
    );
  }
}
