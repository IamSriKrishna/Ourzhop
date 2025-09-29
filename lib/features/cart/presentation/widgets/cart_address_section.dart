import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:customer_app/features/home/presentation/cubit/cart/cart_cubit.dart';
import 'package:customer_app/features/home/presentation/cubit/cart/cart_state.dart';

void _showAddAddressModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => const AddAddressModal(),
  );
}

class CartAddressSection extends StatelessWidget {
  final String addAddressText;

  const CartAddressSection({
    super.key,
    this.addAddressText = 'Add address to Checkout',
  }); 

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Address',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _DeliveryOption(
                      title: 'Delivery',
                      isSelected: state.selectedDeliveryType == DeliveryType.delivery,
                      onTap: () => context.read<CartCubit>().selectDeliveryType(DeliveryType.delivery),
                      colorScheme: colorScheme,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _DeliveryOption(
                      title: 'Pickup',
                      isSelected: state.selectedDeliveryType == DeliveryType.pickup,
                      onTap: () => context.read<CartCubit>().selectDeliveryType(DeliveryType.pickup),
                      colorScheme: colorScheme,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              if (state.hasCompleteAddress)
                _SavedAddressCard(
                  addressState: state,
                  onEdit: () => _showAddAddressModal(context),
                  colorScheme: colorScheme,
                )
              else
                _AddAddressButton(
                  text: addAddressText,
                  onPressed: () => _showAddAddressModal(context),
                  colorScheme: colorScheme,
                ),
            ],
          ),
        );
      },
    );
  }
}

class _SavedAddressCard extends StatelessWidget {
  final CartState addressState;
  final VoidCallback onEdit;
  final ColorScheme colorScheme;

  const _SavedAddressCard({
    required this.addressState,
    required this.onEdit,
    required this.colorScheme,
  });

  IconData _getAddressIcon() {
    switch (addressState.selectedAddressType) {
      case AddressType.home:
        return Icons.home;
      case AddressType.office:
        return Icons.business;
      case AddressType.room:
        return Icons.bed;
    }
  }

  String _getAddressTypeLabel() {
    switch (addressState.selectedAddressType) {
      case AddressType.home:
        return 'Home';
      case AddressType.office:
        return 'Office';
      case AddressType.room:
        return 'Room';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  _getAddressIcon(),
                  color: colorScheme.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          _getAddressTypeLabel(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: colorScheme.primary,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            addressState.selectedDeliveryType == DeliveryType.delivery
                                ? 'Delivery'
                                : 'Pickup',
                            style: TextStyle(
                              color: colorScheme.onPrimary,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _buildFullAddress(),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: onEdit,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.edit_outlined,
                    size: 16,
                    color: colorScheme.primary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Edit Address',
                    style: TextStyle(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _buildFullAddress() {
    final parts = <String>[];
    
    final houseNo = addressState.getAddressField('House / Flat / Block No');
    if (houseNo.isNotEmpty) parts.add(houseNo);
    
    final area = addressState.getAddressField('Apartment / Road / Area');
    if (area.isNotEmpty) parts.add(area);
    
    final cityState = addressState.getAddressField('City & State');
    if (cityState.isNotEmpty) parts.add(cityState);
    
    final zipCode = addressState.getAddressField('Zip Code');
    if (zipCode.isNotEmpty) parts.add(zipCode);
    
    return parts.join(', ');
  }
}

class _DeliveryOption extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  final ColorScheme colorScheme;

  const _DeliveryOption({
    required this.title,
    required this.isSelected,
    required this.onTap,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? colorScheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
          border: isSelected 
            ? null 
            : Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
              color: isSelected ? colorScheme.onPrimary : Colors.grey.shade600,
              size: 16,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? colorScheme.onPrimary : Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddAddressButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ColorScheme colorScheme;

  const _AddAddressButton({
    required this.text,
    required this.onPressed,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: colorScheme.primary),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: colorScheme.primary,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class AddAddressModal extends StatelessWidget {
  const AddAddressModal({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Spacer(),
                const Text(
                  'Add address',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.close, size: 20),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          
          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Location Section
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: colorScheme.primary,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Location',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Address line 1, Address line 2, City\nDistrict - 000 000',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Form Fields
                  _buildTextField(
                    context,
                    label: 'House / Flat / Block No',
                    placeholder: 'No',
                  ),
                  
                  const SizedBox(height: 16),
                  
                  _buildTextField(
                    context,
                    label: 'Apartment / Road / Area',
                    placeholder: 'Location',
                  ),
                  
                  const SizedBox(height: 16),
                  
                  _buildTextField(
                    context,
                    label: 'City & State',
                    placeholder: 'City, State',
                  ),
                  
                  const SizedBox(height: 16),
                  
                  _buildTextField(
                    context,
                    label: 'Zip Code',
                    placeholder: '000 000',
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Select Type
                  const Text(
                    'Select type',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  BlocBuilder<CartCubit, CartState>(
                    builder: (context, state) {
                      return Row(
                        children: [
                          _buildAddressTypeChip(
                            context,
                            type: AddressType.home,
                            label: 'Home',
                            icon: Icons.home,
                            isSelected: state.selectedAddressType == AddressType.home,
                            colorScheme: colorScheme,
                          ),
                          const SizedBox(width: 12),
                          _buildAddressTypeChip(
                            context,
                            type: AddressType.office,
                            label: 'Office',
                            icon: Icons.business,
                            isSelected: state.selectedAddressType == AddressType.office,
                            colorScheme: colorScheme,
                          ),
                          const SizedBox(width: 12),
                          _buildAddressTypeChip(
                            context,
                            type: AddressType.room,
                            label: 'Room',
                            icon: Icons.bed,
                            isSelected: state.selectedAddressType == AddressType.room,
                            colorScheme: colorScheme,
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          
          // Bottom Buttons
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      context.read<CartCubit>().resetAddressForm();
                    },
                    child: Text(
                      'Reset',
                      style: TextStyle(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<CartCubit>().addAddress();
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      foregroundColor: colorScheme.onPrimary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      'Add',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context, {
    required String label,
    required String placeholder,
  }) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              initialValue: state.getAddressField(label),
              decoration: InputDecoration(
                hintText: placeholder,
                hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 14,
                ),
                border: const UnderlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
              ),
              onChanged: (value) {
                context.read<CartCubit>().updateAddressField(label, value);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildAddressTypeChip(
    BuildContext context, {
    required AddressType type,
    required String label,
    required IconData icon,
    required bool isSelected,
    required ColorScheme colorScheme,
  }) {
    return GestureDetector(
      onTap: () {
        context.read<CartCubit>().selectAddressType(type);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? colorScheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? colorScheme.primary : Colors.grey.shade300,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? colorScheme.onPrimary : Colors.grey.shade600,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? colorScheme.onPrimary : Colors.grey.shade600,
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}