import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sql_demo/services/db_helper.dart';

class FinalScreen extends StatefulWidget {
  const FinalScreen({super.key});

  @override
  State<FinalScreen> createState() => _FinalScreenState();
}

class _FinalScreenState extends State<FinalScreen> {
  @override
  Widget build(BuildContext context) {
    //
    TextEditingController _titleController = TextEditingController();
    TextEditingController _descriptionController = TextEditingController();
    //
    List<Map<String, dynamic>> allData = [];
    bool isLoading = true;

    void refeshData() async {
      final data = await DBHelper.getItems();
      setState(() {
        allData = data;
        isLoading = false;

        // print(allData);
      });
    }

    Future<void> addItem() async {
      await DBHelper.createItem(_titleController.text, _descriptionController.text);
      refeshData();
    }

    Future<void> updateItem(int id) async {
      await DBHelper.updateItem(id, _titleController.text, _descriptionController.text);
      refeshData();
    }

    void deleteItem(int id) async {
      await DBHelper.deleteItem(id);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.deepPurpleAccent,
          content: Text('Successfully deleted a Task!'),
        ),
      );
      refeshData();
    }

    //
    void showFormPost(int? id) async {
      if (id != null) {
        final existingPost = allData.firstWhere((element) => element['id'] == id);
        _titleController.text = existingPost['title'];
        _descriptionController.text = existingPost['description'];
      }

      // id = null => create new item
      showModalBottomSheet(
        elevation: 5,
        context: context,
        builder: (_) => Container(
          padding: EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  hintText: 'Enter a title',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  hintText: 'Enter description',
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.deepPurpleAccent),
                ),
                onPressed: () async {
                  if (id == null) {
                    await addItem();
                  }
                  if (id != null) {
                    await updateItem(id);
                  }
                  _titleController.text = '';
                  _descriptionController.text = '';
                  Navigator.pop(context);
                },
                child: Text(id == null ? 'Create New' : 'Update'),
              ),
            ],
          ),
        ),
      );
    }

    //
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 223, 223, 223),
      appBar: AppBar(
        title: Text("App Demo SQL"),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.deepPurpleAccent),
            )
          : allData.isEmpty
              ? Center(
                  child: Column(
                    children: [
                      FadeInUp(
                        child: const Text("All task Done!"),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text("Latest Tasks"),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 700,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: allData.length,
                        itemBuilder: (context, index) => Slidable(
                          key: const ValueKey(0),
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                flex: 2,
                                onPressed: (_) => showFormPost(allData[index]['id']),
                                backgroundColor: Color.fromARGB(255, 223, 223, 223),
                                foregroundColor: Colors.deepPurpleAccent,
                                icon: Icons.edit,
                                label: 'Edit',
                              ),
                              SlidableAction(
                                flex: 2,
                                onPressed: (_) => deleteItem(allData[index]['id']),
                                backgroundColor: const Color.fromARGB(255, 223, 223, 223),
                                foregroundColor: Colors.deepPurpleAccent,
                                icon: Icons.delete,
                                label: 'Delete',
                              ),
                            ],
                          ),
                          child: Card(
                            child: ListTile(
                              title: Text(
                                allData[index]['title'],
                              ),
                              subtitle: Text(
                                allData[index]['description'],
                              ),
                              trailing: const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showFormPost(null);
          print("nhấn thêm nút");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
