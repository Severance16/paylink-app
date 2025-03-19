import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:technical_test/features/recharge/presentation/providers/detail_provider.dart';
import 'package:technical_test/features/recharge/presentation/providers/suppliers_provider.dart';
import 'package:technical_test/features/shared/widgets/custom_modal.dart';

class RechargeDetailScreen extends ConsumerWidget {
  static const name = 'detail';
  final border = Radius.circular(10);
  RechargeDetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(detailProvider);
    final suppliers = ref.watch(suppliersProvider).suppliers;

    if (detail.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/');
            }
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Text('Detalles'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: border,
              bottomRight: border,
              topLeft: border,
            ),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle, size: 60, color: Colors.green),
                const SizedBox(height: 12),
                Text(
                  "Transacción Exitosa",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const Divider(height: 30, thickness: 1),
                _buildDetailRow("Mensaje:", detail.ticket.message),
                _buildDetailRow(
                  "ID Transacción:",
                  detail.ticket.transactionalId,
                ),
                _buildDetailRow("Proveedor:", suppliers.firstWhere((supplier) => supplier.id == detail.ticket.supplierId).name),
                _buildDetailRow("Teléfono:", detail.ticket.cellPhone),
                _buildDetailRow("Valor:", "\$ ${detail.ticket.value}"),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: "edit", // Evita conflictos con múltiples FABs
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => CustomModal(isEditMode: true),
              );
            },
            backgroundColor: Color.fromRGBO(49, 54, 63, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: const Icon(
              Icons.edit,
              size: 28,
              color: Color.fromRGBO(238, 238, 238, 1),
            ),
          ),
          const SizedBox(height: 12), // Espaciado entre botones
          FloatingActionButton(
            heroTag: "delete",
            onPressed: () {
              showDialog(
                context: context,
                builder:
                    (context) => CustomModal(
                      isEditMode: false,
                      onDeleteConfirm: () async {
                        // Acción al confirmar la eliminación
                        ref
                            .read(detailProvider.notifier)
                            .deleteTicketById(detail.ticket.id);
                        context.pop();
                      },
                    ),
              );
            },
            backgroundColor: const Color.fromRGBO(49, 54, 63, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: const Icon(
              Icons.delete_outline,
              size: 28,
              color: Color.fromRGBO(238, 238, 238, 1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(value, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
