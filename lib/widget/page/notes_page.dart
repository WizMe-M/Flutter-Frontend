import 'package:flutter/material.dart';
import 'package:flutter_frontend/dio_client.dart';
import 'package:flutter_frontend/model/note.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key, required this.token}) : super(key: key);

  final String token;

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final DioClient _client = DioClient();

  List<Note> noteList = [];

  @override
  void initState() {
    super.initState();
    fetchNotes();
  }

  void fetchNotes() async {
    var response = await _client.getNote(token: widget.token);
    var notes = response!.data as List<dynamic>;
    setState(() {
      for (var element in notes) {
        var note = Note.fromJson(element);
        noteList.add(note);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ...noteList.map((e) => Padding(
                    padding: const EdgeInsets.all(20),
                    child: SizedBox(
                      height: 150,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text('ID: ${e.id}'),
                              Padding(
                                padding: const EdgeInsets.only(left: 40),
                                child: Text('Name: ${e.name}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Created at: ${e.createdDate}',
                                  style: const TextStyle(color: Colors.black38),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 40),
                                  child: Text(
                                      'Edited at: ${e.editedDate ?? 'Not edited'}',
                                      style: const TextStyle(
                                          color: Colors.black38)),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.black)),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text('Content: ${e.content}',
                                    maxLines: 4,
                                    overflow: TextOverflow.clip,
                                    softWrap: true),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
