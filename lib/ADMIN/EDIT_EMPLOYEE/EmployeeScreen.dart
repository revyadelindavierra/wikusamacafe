import 'package:flutter/material.dart';
import 'package:wikusamacafe/ADMIN/EDIT_EMPLOYEE/New_employ.dart';
import 'package:wikusamacafe/ADMIN/EDIT_EMPLOYEE/Services/EmployeeService.dart';
import 'package:wikusamacafe/ADMIN/EDIT_EMPLOYEE/editpage.dart';
import 'package:wikusamacafe/ADMIN/EDIT_EMPLOYEE/models/EmployeeModel.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserService userService = UserService();

  Future<void> _showDeleteConfirmationDialog(
      BuildContext context, String userId) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete User'),
          content: Text('Are you sure you want to delete this user?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text('No'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text('Yes'),
            ),
          ],
        );
      },
    );

    if (shouldDelete == true) {
      await userService.deleteUser(userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFF016042),
          title: Center(
            child: Text(
              'Employee',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white54,
            tabs: [
              Tab(
                child: Text(
                  'Manager',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Tab(
                child: Text(
                  'Admin',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Tab(
                child: Text(
                  'Cashier',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildUserList(UserRole.manager),
            _buildUserList(UserRole.admin),
            _buildUserList(UserRole.cashier),
          ],
        ),
        bottomNavigationBar: SizedBox(
          height: 64,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddUserPage()),
              );
            },
            child: Stack(
              children: [
                Positioned(
                  left: 5,
                  right: 5,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 55,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF016042),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: const Text(
                    'Add User',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserList(UserRole role) {
    return StreamBuilder<List<User>>(
      stream: userService.getUserStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No users found'));
        }

        final users =
            snapshot.data!.where((user) => user.role == role).toList();

        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 35),
                  title: Text(
                    user.name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      _showDeleteConfirmationDialog(context, user.id);
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditUserPage(user: user),
                      ),
                    );
                  },
                ),
                Divider(thickness: 1, color: Colors.grey[300]),
              ],
            );
          },
        );
      },
    );
  }
}
