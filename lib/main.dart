import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ecommerce App',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1; // Set default selected index to ProductScreen (1)

  static List<Widget> _widgetOptions = <Widget>[
    LoginScreen(),
    ProductScreen(),
    AboutScreen(),
    ContactScreen(), // Added ContactScreen
  ];

  static List<int> _appBarScreens = [1]; // List of screens that require app bar (ProductScreen)

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarScreens.contains(_selectedIndex)
          ? AppBar(
              title: Row(
                children: [
                  Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbYWzxOUpg-mzWeAXIZDk84tzfVBpz9hRWxA&s',
                    width: 30, // Adjust size as needed
                    height: 30, // Adjust size as needed
                  ),
                  SizedBox(width: 8),
                  Text('FRAGRANCE HEAVEN'),
                ],
              ),
              backgroundColor: Colors.lightBlue,
              actions: [
                IconButton(
                  icon: Icon(Icons.search_sharp),
                  onPressed: () {
                    // Handle search button press
                    showSearch(
                      context: context,
                      delegate: CustomSearchDelegate(),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.shopping_basket),
                  onPressed: () {
                    // Navigate to CartScreen
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CartScreen(),
                      ),
                    );
                  },
                ),
              ],
            )
          : null,
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.login),
            label: 'LOGIN',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'ABOUT',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_mail), // Changed icon to Contact icon
            label: 'CONTACT', // Changed label to 'CONTACT'
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.lightBlue,
        unselectedItemColor: Colors.grey,
        selectedIconTheme: IconThemeData(size: 30),
        onTap: _onItemTapped,
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _submitForm(BuildContext context) {
    String username = _usernameController.text;
    String password = _passwordController.text;

    // Basic validation (you can implement more advanced validation logic here)
    if (username == 'SAI' && password == '123456') {
      print('Username: $username');
      print('Password: $password');

      // Navigate to HomeScreen after successful login
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      // Show an error message or handle invalid input
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Invalid username or password.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 151, 219, 251), // Set background color for the scaffold
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8, // Adjust width as needed
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white.withOpacity(0.8), // White with opacity
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    // Added heading for FRAGRANCE HEAVEN
                    Text(
                      'FRAGRANCE HEAVEN',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        labelStyle: TextStyle(color: Colors.black), // Label text color
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black), // Border color when focused
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.black), // Label text color
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black), // Border color when focused
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () {
                        _submitForm(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          'Login',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductScreen extends StatelessWidget {
  final List<Map<String, String>> products = [
    {
      'image': 'https://m.media-amazon.com/images/I/615ADrNaSEL._AC_UF1000,1000_QL80_.jpg',
      'title': 'BEARDO WHISKY SMOKE PERFUME ',
      'price': '₹999',
      'discount': '70% savings',
      'mrp': 'M.R.P.: ₹2,000',
      'taxes': 'Inclusive of all taxes',
    },
    {
      'image': 'https://m.media-amazon.com/images/I/71qWo7ELB5L._AC_UF1000,1000_QL80_.jpg',
      'title': 'WILD BLUE AQUA PERFUME ',
      'price': '₹949',
      'discount': '18% savings',
      'mrp': 'M.R.P.: ₹1,599.00',
      'taxes': 'Inclusive of all taxes',
    },
    {
      'image': 'https://codegrooming.com/cdn/shop/files/CODE_PERFUME_PRODUCTS_01_533x.jpg?v=1696827184',
      'title': 'CODE TRIO LUXURY PERFUMES',
      'price': '₹2,199.00',
      'discount': '40% savings',
      'mrp': 'M.R.P.: ₹3,897.00',
      'taxes': 'Inclusive of all taxes',
    },
    {
      'image': 'https://m.media-amazon.com/images/I/61k2RGYw+yL._AC_UF1000,1000_QL80_.jpg',
      'title': 'GAME CHANGER PERFUME',
      'price': '₹1,200',
      'discount': '63% savings',
      'mrp': 'M.R.P.: ₹1,800',
      'taxes': 'Inclusive of all taxes',
    },
    {
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRJ8Lo1ekUXgteuP7pHC6OxZ1GpuzSbsetlBg&s',
      'title': 'ARABIAN UNISEX',
      'price': '₹1,799',
      'discount': '34% savings',
      'mrp': 'M.R.P.: ₹2,500',
      'taxes': 'Inclusive of all taxes',
    },
    {
      'image': 'https://www.mystore.in/s/62ea2c599d1398fa16dbae0a/6578436467e294b81b27f8d9/hamidi-oud-admire2-1200x1200.jpg',
      'title': 'ADMIRE UNISEX',
      'price': '₹999',
      'discount': '65% savings',
      'mrp': 'M.R.P.: ₹1500',
      'taxes': 'Inclusive of all taxes',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.7, // Adjust the aspect ratio as needed
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    products[index]['image'] ?? '',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      products[index]['title'] ?? '',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      products[index]['price'] ?? '',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      products[index]['discount'] ?? '',
                    ),
                    SizedBox(height: 4),
                    Text(
                      products[index]['mrp'] ?? '',
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      products[index]['taxes'] ?? '',
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Buy button action
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Buy Product'),
                                  content: Text('You clicked on Buy for ${products[index]['title']}'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Text('Buy'),
                        ),
                        SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            // Add to Cart button action
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Add to Cart'),
                                  content: Text('You added ${products[index]['title']} to your cart.'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Text('Add to Cart'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('WELCOME TO FRAGRANCE HEAVEN,WHERE EVERY SCENT TELLS A UNIQUE STORY.OUR CURATED COLLECTION FEATURES A DIVERSE RANGE OF PREMIUS PERFUMES AND COLOGNES THAT CATER TO EVERY PERSONALITY', style: TextStyle(fontSize: 24)),
    );
  }
}

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
        backgroundColor: Colors.lightBlue,
      ),
      backgroundColor: const Color.fromARGB(255, 188, 230, 141), // Set lime color background
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _phoneNumberController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 12),
            TextField(
              controller: _stateController,
              decoration: InputDecoration(
                labelText: 'State',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'City',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle form submission
                String name = _nameController.text;
                String phoneNumber = _phoneNumberController.text;
                String state = _stateController.text;
                String city = _cityController.text;

                // Here you can implement further logic like form validation, sending data, etc.

                // For now, just print the values
                print('Name: $name');
                print('Phone Number: $phoneNumber');
                print('State: $state');
                print('City: $city');

                // Show a dialog or navigate to a confirmation screen
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Contact Form Submitted'),
                      content: Text('Name: $name\nPhone: $phoneNumber\nState: $state\nCity: $city'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Implement search results screen
    return Center(
      child: Text('Search results for: $query'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Implement suggestion based on query (if needed)
    return Center(
      child: Text('Search suggestions for: $query'),
    );
  }
}

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart, size: 100, color: Colors.limeAccent),
          SizedBox(height: 20),
          Text('Cart Screen', style: TextStyle(fontSize: 24)),
        ],
      ),
    );
  }
}