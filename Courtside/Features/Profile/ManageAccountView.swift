import SwiftUI

public struct ManageAccountView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showLogOutDialog = false
    @State private var showDeleteDialog = false
    @State private var showDeleteConfirmAlert = false
    @State private var showChangePassword = false

    public init() {}

    public var body: some View {
        ZStack {
            Color.Courtside.background.ignoresSafeArea()

            VStack(spacing: 0) {
                // Custom Header
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 20))
                            .foregroundStyle(.Courtside.textPrimary)
                    }

                    Spacer()

                    Text("MANAGE ACCOUNT")
                        .font(.custom("PlusJakartaSans-SemiBold", size: 14))
                        .foregroundStyle(.Courtside.textPrimary)
                        .kerning(1.5)

                    Spacer()

                    Image(systemName: "arrow.left")
                        .font(.system(size: 20))
                        .opacity(0)
                }
                .padding(.horizontal, 24)
                .padding(.top, 16)
                .padding(.bottom, 16)

                Divider()
                    .background(Color.Courtside.textSecondary.opacity(0.1))

                ScrollView {
                    VStack(alignment: .leading, spacing: 32) {

                        SettingsGroupView(title: "PERSONAL DETAILS") {
                            SettingsRowView(icon: "person", title: "Full Name", value: "Michael Chen")
                            SettingsRowView(icon: "envelope", title: "Email", value: "m.chen@example.com")
                            SettingsRowView(icon: "phone", title: "Phone Number", value: "+91 98765 43210", showDivider: false)
                        }
                        .padding(.top, 32)

                        SettingsGroupView(title: "MEMBERSHIP") {
                            SettingsRowView(icon: "star", title: "Current Tier", value: "Founding Member")
                            SettingsRowView(icon: "calendar.badge.clock", title: "Renewal Date", value: "12 Jan 2025", showDivider: false)
                        }

                        SettingsGroupView(title: "SECURITY") {
                            SettingsRowView(icon: "lock", title: "Change Password") {
                                showChangePassword = true
                            }

                            // Log Out
                            Button(action: { showLogOutDialog = true }) {
                                HStack(spacing: 16) {
                                    Image(systemName: "rectangle.portrait.and.arrow.right")
                                        .font(.system(size: 16, weight: .light))
                                        .foregroundStyle(.red)
                                        .frame(width: 24)

                                    Text("Log Out")
                                        .font(.custom("PlusJakartaSans-SemiBold", size: 16))
                                        .foregroundStyle(.red)

                                    Spacer()
                                }
                                .padding(20)
                                .background(Color.white)
                            }

                            Divider()
                                .background(Color.Courtside.textSecondary.opacity(0.1))

                            // Delete Account
                            Button(action: { showDeleteDialog = true }) {
                                HStack(spacing: 16) {
                                    Image(systemName: "trash")
                                        .font(.system(size: 16, weight: .light))
                                        .foregroundStyle(.Courtside.textSecondary)
                                        .frame(width: 24)

                                    Text("Delete Account")
                                        .font(.custom("PlusJakartaSans-Regular", size: 16))
                                        .foregroundStyle(.Courtside.textSecondary)

                                    Spacer()
                                }
                                .padding(20)
                                .background(Color.white)
                            }
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 64)
                }
                .scrollIndicators(.hidden)
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .confirmationDialog("Log Out", isPresented: $showLogOutDialog, titleVisibility: .visible) {
            Button("Log Out", role: .destructive) {
                UserDefaults.standard.set(false, forKey: "hasSeenOnboarding")
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("You will need to sign in again.")
        }
        .confirmationDialog("Delete Account", isPresented: $showDeleteDialog, titleVisibility: .visible) {
            Button("Request Deletion", role: .destructive) {
                showDeleteConfirmAlert = true
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Your data will be permanently deleted within 30 days.")
        }
        .alert("Request Submitted", isPresented: $showDeleteConfirmAlert) {
        } message: {
            Text("We've received your account deletion request.")
        }
        .sheet(isPresented: $showChangePassword) {
            ChangePasswordSheet()
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
        }
    }
}
