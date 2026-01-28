import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../core/entities/document.dart';
import '../providers/providers.dart';

class DocumentListScreen extends ConsumerWidget {
  const DocumentListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LateMD'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // TODO: Navigate to settings screen
            },
          ),
        ],
      ),
      body: _buildDocumentList(ref),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _createNewDocument(ref);
        },
        tooltip: 'Create New Document',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildDocumentList(WidgetRef ref) {
    return FutureBuilder<List<Document>>(
      future: ref.read(getAllDocumentsProvider).call(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final documents = snapshot.data ?? [];

        if (documents.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.note_add, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text('No documents yet. Tap the "+" button to create one.'),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: documents.length,
          itemBuilder: (context, index) {
            final document = documents[index];
            return ListTile(
              title: Text(document.title),
              subtitle: Text('Updated: ${document.updatedAt.toString().split(' ')[0]}'),
              onTap: () {
                // TODO: Navigate to document editor
              },
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  _deleteDocument(ref, document.id);
                },
              ),
            );
          },
        );
      },
    );
  }

  void _createNewDocument(WidgetRef ref) {
    final uuid = Uuid();
    final newDocument = Document(
      id: uuid.v4(),
      title: 'Untitled Document',
      path: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      blockIds: [],
      metadata: {},
    );

    ref.read(createDocumentProvider).call(newDocument);
  }

  void _deleteDocument(WidgetRef ref, String documentId) {
    ref.read(deleteDocumentProvider).call(documentId);
  }
}
