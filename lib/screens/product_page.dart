import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final List<Product> _products = [];

  Future<void> _addProduct() async {
    final result = await showDialog<Product>(
      context: context,
      builder: (_) => const _ProductDialog(),
    );
    if (result != null) {
      setState(() {
        _products.add(result); // CREATE
      });
    }
  }

  Future<void> _editProduct(Product product) async {
    final result = await showDialog<Product>(
      context: context,
      builder: (_) => _ProductDialog(product: product),
    );
    if (result != null) {
      setState(() {
        final index =
            _products.indexWhere((element) => element.id == product.id);
        if (index != -1) {
          _products[index] = result; // UPDATE
        }
      });
    }
  }

  void _deleteProduct(String id) {
    setState(() {
      _products.removeWhere((p) => p.id == id); // DELETE
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Produk'),
      ),
      body: _products.isEmpty
          ? const Center(child: Text('Belum ada produk'))
          : ListView.builder(
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final p = _products[index];
                return ListTile(
                  title: Text(p.name),
                  subtitle: Text('Rp ${p.price}'),
                  onTap: () {
                    // READ detail sederhana
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text(p.name),
                        content: Text('Harga: Rp ${p.price}'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Tutup'),
                          ),
                        ],
                      ),
                    );
                  },
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _editProduct(p),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteProduct(p.id),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addProduct,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _ProductDialog extends StatefulWidget {
  final Product? product;

  const _ProductDialog({this.product});

  @override
  State<_ProductDialog> createState() => _ProductDialogState();
}

class _ProductDialogState extends State<_ProductDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameCtrl;
  late TextEditingController _priceCtrl;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.product?.name ?? '');
    _priceCtrl =
        TextEditingController(text: widget.product?.price.toString() ?? '');
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _priceCtrl.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final name = _nameCtrl.text;
    final price = int.tryParse(_priceCtrl.text) ?? 0;

    final product = Product(
      id: widget.product?.id ?? DateTime.now().toString(),
      name: name,
      price: price,
    );

    Navigator.pop(context, product);
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.product != null;

    return AlertDialog(
      title: Text(isEdit ? 'Edit Produk' : 'Tambah Produk'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameCtrl,
              decoration: const InputDecoration(labelText: 'Nama produk'),
              validator: (v) =>
                  v == null || v.isEmpty ? 'Nama wajib diisi' : null,
            ),
            TextFormField(
              controller: _priceCtrl,
              decoration: const InputDecoration(labelText: 'Harga'),
              keyboardType: TextInputType.number,
              validator: (v) =>
                  v == null || v.isEmpty ? 'Harga wajib diisi' : null,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        ElevatedButton(
          onPressed: _save,
          child: Text(isEdit ? 'Simpan' : 'Tambah'),
        ),
      ],
    );
  }
}
